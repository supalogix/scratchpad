import {createStore, combineReducers} from "redux"
import {expect} from "chai"
import cx from "classnames"

const identityInitialState = {
	username: "",
	password: ""
};

const identity = (state = identityInitialState, action = {}) => {
	switch(action.type)
	{
		case "USERNAME_CHANGED": 
			return {
				...state,
				username: action.payload.username
			};

		case "PASSWORD_CHANGED": 
			return {
				...state,
				password: action.payload.password
			};

		default:
			return state;
	}
};


const usernameChanged = (username) => ({
	type: "USERNAME_CHANGED",
	payload: {
		username
	}
});

const passwordChanged = (password) => ({
	type: "PASSWORD_CHANGED",
	payload: {
		password
	}
});

const JaneEntersAValidUsername = [
	usernameChanged("jane.doe")
];

const JaneEntersAValidPassword = [
	passwordChanged("Qwerty!234")
]

const JaneLogsInSuccessfully = [
	...JaneEntersAValidUsername,
	...JaneEntersAValidPassword
];

const getStateForScenario = (log) => {

	const store = createStore(combineReducers({
		identity
	}));

	log.forEach(action => store.dispatch(action))

	return store.getState();
};

const selectorFactory = dispatch => state => {
	const {
		username,
		password
	} = state.identity;

	const onUsernameChanged = (e) => dispatch(usernameChanged(e.value));
	const onPasswordChanged = (e) => dispatch(passwordChanged(e.value));

	return {
		style: {
			username: cx(
				"bg-white"
			),
			password: ""
		},
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


const getSimulation = scenario => {
	const log = [];
	const dispatch = action => log.push(action);
	
	const reduxState = getStateForScenario(scenario);
	const state = selectorFactory(dispatch)(reduxState);

	return {
		log,
		state
	}
};

const testEventHandlers = () => it("tests event handlers", () => {
	const {log, state} = getSimulation([]);

	state.method.onUsernameChanged({
		value: "john.doe"
	});
	state.method.onPasswordChanged({
		value: "Qwerty!234"
	});

	expect(log).to.deep.equal([
		usernameChanged("john.doe"),
		passwordChanged("Qwerty!234")
	]);
});

const testJaneEntersUsername = () =>  it("tests scenario 'Jane enters a valid username'", () => {
	const {log, state} = getSimulation(JaneEntersAValidUsername);

	expect(state.data.username).to.equal("jane.doe");

});

describe("login selectorFactory", () => {
	testStyles();
	testEventHandlers();
	testJaneEntersUsername();
	testJaneEntersPassword();
	testJaneLogsInSuccessfully();
});

function testJaneEntersPassword()
{
	it("tests scenario 'Jane enters a valid password'", () => {
		const {log, state} = getSimulation(JaneEntersAValidPassword);

		expect(state.data.password).to.equal("Qwerty!234");
	});
}

function testJaneLogsInSuccessfully()
{
	it("tests scenario 'Jane logs in successfully'", () => {
		const {log, state} = getSimulation(JaneLogsInSuccessfully);

		expect(state.data).to.deep.equal({
			username: "jane.doe",
			password: "Qwerty!234"
		});
	});
}

function testStyles()
{
	it("tests styles", () => {
		const {log, state} = getSimulation([]);

		expect(state.style).to.deep.equal({
			username: "bg-white",
			password: ""
		});
	});
}
