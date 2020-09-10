const {createStore, combineReducers} = require("redux");
const {createSelector} = require("reselect");
const produce = require("immer").default;

const createRpcWebApi = (env) => { }

const createMockApi = env => {
	const login = (props) => Promise.resolve({
		statusCode: 200	
	});
	return {
		login
	}
};

const createContext = (env) => {
	return createMockApi(env);
};

const ActionType = {
	CHANGE_USERNAME: "CHANGE_USERNAME",
	CHANGE_PASSWORD: "CHANGE_PASSWORD"
};

const changeUsername = username => ({
	type: ActionType.CHANGE_USERNAME,
	payload: {
		username
	}
});

const changePassword = password => ({
	type: ActionType.CHANGE_PASSWORD,
	payload: {
		password
	}
});

const generateState = reducers => actions => {
	const store = createStore(combineReducers(reducers));
	actions.forEach(action => store.dispatch(action));
	return store.getState();
};

const loginInitialState = {
	username: "",
	password: ""
};

const login = (state = loginInitialState, action = {}) => produce(state, draft => {
	switch(action.type)
	{
		case ActionType.CHANGE_USERNAME:
			draft.username = action.payload.username;

		case ActionType.CHANGE_PASSWORD:
			draft.password = action.payload.password;
	}
});

const reducers = {
	login
};

const Login = {};

Login.createScenario1 = ids => ([
	{
		type: "LOAD_APP"
	},
	changeUsername("john.doe"),
	changePassword("password"),
]);
Login.createScenario2 = ids => ([
	...Login.createScenario1(),
	{
		type: "REQUEST_LOGIN"
	}
]);
Login.createScenario3 = ids => ([
	...Login.createScenario2(),
	{
		type: "LOGIN_GRANTED",
		payload: { }
	}
]);

const attemptToLogin = (dispatch) => (state) => (action) => new Promise(resolve => {
	const actions = [
		{
			type: "LOGIN_GRANTED"
		}
	];
	dispatch({
		type: "LOGIN_GRANTED"
	})
	resolve(actions);
});

const createEventStore = () => {
	const logs = [];
	return {
		dispatch: (action) => logs.push(action),
		getLogs: () => logs
	}
};

const createReplayContext = reducers => eventStore => actions => {
	const state = generateState(reducers)(actions);

	return {
		attemptToLogin: attemptToLogin(eventStore.dispatch)(state)
	}
};

Login.executeScenario3 = ids => async replayContext => {
	const scenario2 = Login.createScenario2(ids);
	const action = { };
	const eventLog = await replayContext(scenario2).attemptToLogin(action);
	return scenario2.concat(eventLog)
}

const sfLogin = dispatch => state => {
	const username = state.login.username;
	const password = state.login.password;

	const onUsernameChanged = ev => dispatch(changeUsername(ev.target.value));
	const onPasswordChanged = ev => dispatch(changePassword(ev.target.value));

	return {
		data: {
			username,
			password
		},
		method: {
			onUsernameChanged,
			onPasswordChanged
		}
	}
};


const main = async () => {
	const context = createContext({});
	const response = await context.login();
	console.log(response);
	const eventStore = createEventStore();

	const state = generateState(reducers)(Login.createScenario1());
	console.log(JSON.stringify(state, null, 2));

	const replayContext = createReplayContext(reducers)(eventStore);
	const logs = await Login.executeScenario3
		({})
		(replayContext);
	console.log(logs);

	const _eventStore = createEventStore();
	const _state = generateState(reducers)([]);
	const sf = sfLogin(_eventStore.dispatch)(_state);
	sf.method.onUsernameChanged({
		target: {
			value: "john.doe"
		}
	});
	sf.method.onPasswordChanged({
		target: {
			value: "Qwerty!234"
		}
	});

	console.log(_eventStore.getLogs());

};

main();
