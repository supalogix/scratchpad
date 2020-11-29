const {add_nodes, add_child, combine} = require("../mutator");
const r1 = require("../r1");
const r2 = require("../r2");
const r3 = require("../r3");
const r4 = require("../r4");
const r5 = require("../r5");
const r6 = require("../r6");
const r7 = require("../r7");
const r8 = require("../r8");

const D = combine("D", r8.r8_a, [
	r4.r4_a,
	r8.r8_b,
])

const B = combine("B", r1.r1_d, [
	r1.r1_e, 
	r2.r2_a, 
	r4.r4_c, 
	r5.r5_a, 
	r7.r7_a
]);

const E = combine("E", r5.r5_b, [
	r3.r3_c,
	r5.r5_c
]);


const A = combine("A", r6.r6_b, [
	r3.r3_a,
	r6.r6_c
]);

const C = combine("C", r6.r6_d, [
	r1.r1_a,
	r6.r6_e
]);

add_child(C, r8.r8_a)

module.exports = {
    root: [
		r6.r6_a
	],
    nodes: [
		...r1.nodes,
		...r2.nodes,
		...r3.nodes,
		...r4.nodes,
		...r5.nodes,
		...r6.nodes,
		...r7.nodes,
		...r8.nodes,
		A,
		B,
		C,
		D,
		E,
    ]
}