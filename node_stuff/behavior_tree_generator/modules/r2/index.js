const {add_nodes, add_child} = require("../mutator");

let nodes = []

const r2_a = {
	id: "r2_a",
	_id: "2a",
	title: String.raw`Oven [Cooking]`,
	parent_node: null,
	children: []
};

const r2_b = {
	id: "r2_b",
	_id: "2b",
	title: "User ???PushButton???",
	parent_node: null,
	children: []
};

const r2_c = {
	id: "r2_c",
	_id: "2c",
	title: "Button [Pushed]",
	parent_node: null,
	children: []
};

const r2_d = {
	id: "r2_d",
	_id: "2d",
	title: "Oven [ExtraMin]",
	parent_node: null,
	children: []
};

const r2_e = {
	id: "r2_e",
	_id: "2e",
	title: "Oven [Cooking]",
	parent_node: null,
	children: []
};

add_child(r2_a, r2_b);
add_child(r2_b, r2_c);
add_child(r2_c, r2_d);
add_child(r2_d, r2_e);

module.exports = {
    root: [r2_a],
    nodes: [
        r2_a,
        r2_b,
        r2_c,
        r2_d,
        r2_e
    ],
        r2_a,
        r2_b,
        r2_c,
        r2_d,
        r2_e
}