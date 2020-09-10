const { createStore, combineReducers } = require("redux");
const { fromJS } = require("immutable");
const { expect } = require("chai");
const { createSelector } = require("reselect");

const ON_ENTER = "[login] ON_ENTER";
const ON_EXIT = "[login] ON_EXIT";
const CHANGE_USERNAME = "[login] CHANGE_USERNAME";
const CHANGE_PASSWORD = "[login] CHANGE_PASSWORD";

const MODE = "mode";
const USERNAME = "username";
const PASSWORD = "password"

const initialState = fromJS({
    [MODE]: "NOT_ACTIVE",
    [USERNAME]: "",
    [PASSWORD]: ""
});

const login = (state = initialState, action = {}) => {
    const handlerForAction = {
        [ON_ENTER]: handleOnEnter,
        [CHANGE_USERNAME]: handleChangeUsername,
        [CHANGE_PASSWORD]: handleChangePassword,
        [ON_EXIT]: handleOnExit,
    };

    if(action.type in handlerForAction)
        return handlerForAction[action.type](state, action);
    else
        return state;
}

function handleOnEnter(state, action) 
{
    return state.set(MODE, "ACTIVE");
}

function handleOnExit(state, action)
{
    return state.set(MODE, "NOT_ACTIVE");
}

function handleChangeUsername(state, action)
{
    return state.set(USERNAME, action.payload.username);
}

function handleChangePassword(state, action)
{
    return state.set(PASSWORD, action.payload.password);
}

const onEnter = () => ({
    type: ON_ENTER,
    payload: {}
})

const onExit = () => ({
    type: ON_EXIT,
    payload: {}
})

const changeUsername = (username = "") => ({
    type: CHANGE_USERNAME,
    payload: {
        username
    }
});

const changePassword = (password = "") => ({
    type: CHANGE_PASSWORD,
    payload: {
        password
    }
});

const LoginProperties = createSelector(
    state => state.login,
    (state) => ({
        username: state.get("username"),
        password: state.get("password")
    }))

const us1a = {
    name: "the website authenticates Jane Doe",
    simulations: [
        {
            name: "Jane Doe enters the login page",
            actions: [
                onEnter()
            ],
            test: (state) => {
                expect(state.login.get(MODE)).to.equal("ACTIVE")
            }
        },
        {
            name: "Jane Doe changes the username to 'jane.doe'",
            actions: [
                changeUsername("jane.doe")
            ],
            test: (state) => {
                expect(state.login.toJS().username).to.equal("jane.doe")
            }
        },
        {
            name: "Jane Doe changes the password to 'abcd'",
            actions: [
                changePassword("asdf")
            ],
            test: (state) => {
                const loginProperties = LoginProperties(state);
                expect(state.login.toJS().password).to.equal("asdf");
                expect(loginProperties).to.deep.equal({
                    username: "jane.doe",
                    password: "asdf"
                });
            }
        },
    ],
    e2e: (user) => {

    }
}


const simulate = (userStories) => {
    const store = createStore(combineReducers({
        login
    }));

    userStories.forEach(userStory => {
        console.log(userStory.name)

        userStory.simulations.forEach(simulation => {
            console.log(`\t${simulation.name}`)
            simulation.actions.forEach(action => store.dispatch(action))
            simulation.test(store.getState())
        })

    })
}

const simulations = [
    us1a
]

simulate(simulations);
