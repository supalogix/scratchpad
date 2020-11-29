const {add_nodes, add_child} = require("../mutator");

const r5_a = {
	id: "r5_a",
	_id: "5a",
	title: "Oven [Cooking]",
	parent_node: null,
	children: []
};

const r5_b = {
	id: "r5_b",
	_id: "5b",
	title: "User ???DoorOpen???",
	parent_node: null,
	children: []
};

const r5_c = {
	id: "r5_c",
	_id: "5c",
	title: "Door [Open]",
	parent_node: null,
	children: []
};

const r5_d = {
	id: "r5_d",
	_id: "5d",
	title: "Powertube [Off]",
	parent_node: null,
	children: []
};

const r5_e = {
	id: "r5_e",
	_id: "5e",
	title: "Oven [CookStop]",
	parent_node: null,
	children: []
};

const r5_f = {
	id: "r5_f",
	_id: "5f",
	title: "Oven [Open]",
	parent_node: null,
	children: []
};


add_child(r5_a, r5_b);
add_child(r5_b, r5_c);
add_child(r5_c, r5_d);
add_child(r5_d, r5_e);
add_child(r5_e, r5_f);

module.exports = {
    root: [
		r5_a
	],
    nodes: [
        r5_a,
        r5_b,
        r5_c,
        r5_d,
        r5_e,
        r5_f,
    ],
        r5_a,
        r5_b,
        r5_c,
        r5_d,
        r5_e,
        r5_f,
}