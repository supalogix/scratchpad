const {add_nodes, add_child} = require("../mutator");

let nodes = []

const r1_a = {
	id: "r1_a",
	_id: "1a",
	title: "Oven [Idle]",
	parent_node: null,
	children: []
};

const r1_b = {
	id: "r1_b",
	_id: "1b",
	title: "User ???PushButton???",
	parent_node: null,
	children: []
};

const r1_c = {
	id: "r1_c",
	_id: "1c",
	title: "Button [Pushed]",
	parent_node: null,
	children: []
};

const r1_d = {
	id: "r1_d",
	_id: "1d",
	title: "Powertube [Energized]",
	parent_node: null,
	children: []
};

const r1_e = {
	id: "r1_e",
	_id: "1e",
	title: "Oven [Cooking]",
	parent_node: null,
	children: []
};

nodes = add_nodes(nodes, [
	r1_a,
	r1_b,
	r1_c,
	r1_d,
	r1_e,
]);

add_child(r1_a, r1_b);
add_child(r1_b, r1_c);
add_child(r1_c, r1_d);
add_child(r1_d, r1_e);

module.exports = {
    root: [r1_a],
    nodes: [
        r1_a,
        r1_b,
        r1_c,
        r1_d,
        r1_e
    ],
    r1_a,
    r1_b,
    r1_c,
    r1_d,
    r1_e
}