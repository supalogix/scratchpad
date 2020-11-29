const {add_nodes, add_child} = require("../mutator");

const r7_a = {
	id: "r7_a",
	_id: "7a",
	title: "Oven [Cooking]",
	parent_node: null,
	children: []
};

const r7_b = {
	id: "r7_b",
	_id: "7b",
	title: "Oven ???TimeOut???",
	parent_node: null,
	children: []
};

const r7_c = {
	id: "r7_c",
	_id: "7c",
	title: "Light [Off]",
	parent_node: null,
	children: []
};

const r7_d = {
	id: "r7_d",
	_id: "7d",
	title: "Powertube [Off]",
	parent_node: null,
	children: []
};

const r7_e = {
	id: "r7_e",
	_id: "7e",
	title: "Beeper [Sounded]",
	parent_node: null,
	children: []
};

const r7_f = {
	id: "r7_f",
	_id: "7f",
	title: "Oven [CookFinish]",
	parent_node: null,
	children: []
};

const r7_g = {
	id: "r7_g",
	_id: "7g",
	title: "Oven ^[Idle]",
	parent_node: null,
	children: []
};

add_child(r7_a, r7_b);
add_child(r7_b, r7_c);
add_child(r7_c, r7_d);
add_child(r7_d, r7_e);
add_child(r7_e, r7_f);

module.exports = {
    root: [
		r7_a
	],
    nodes: [
        r7_a,
        r7_b,
        r7_c,
        r7_d,
        r7_e,
        r7_f,
    ],
        r7_a,
        r7_b,
        r7_c,
        r7_d,
        r7_e,
        r7_f,
}