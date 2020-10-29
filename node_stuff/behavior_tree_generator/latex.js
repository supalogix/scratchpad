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


const r3_a = {
	id: "r3_a",
	_id: "3a",
	title: "Door [Closed]",
	parent_node: null,
	children: []
}

const r3_b = {
	id: "r3_b",
	_id: "3b",
	title: "Button [Enabled]",
	parent_node: null,
	children: []
}

const r3_c = {
	id: "r3_c",
	_id: "3c",
	title: "Door [Open]",
	parent_node: null,
	children: []
}


const r3_d = {
	id: "r3_d",
	_id: "3d",
	title: "Button [Disabled]",
	parent_node: null,
	children: []
}

add_child(r3_a, r3_b);
add_child(r3_c, r3_d);

const r4_a = {
	id: "r4_a",
	_id: "4a",
	title: "Door [Open]",
	parent_node: null,
	children: []
}

const r4_b = {
	id: "r4_b",
	_id: "4b",
	title: "Light [On]",
	parent_node: null,
	children: []
}

const r4_c = {
	id: "r4_c",
	_id: "4c",
	title: "Oven [Cooking]",
	parent_node: null,
	children: []
}


const r4_d = {
	id: "r4_d",
	_id: "4d",
	title: "Light [On]",
	parent_node: null,
	children: []
}

add_child(r4_a, r4_b);
add_child(r4_c, r4_d);

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

const r6_a = {
	id: "r6_a",
	_id: "6a",
	title: `Oven [Open]`,
	parent_node: null,
	children: []
};

const r6_b = {
	id: "r6_b",
	_id: "6b",
	title: "User ???DoorClosed???",
	parent_node: null,
	children: []
};

const r6_c = {
	id: "r6_c",
	_id: "6c",
	title: "Door [Closed]",
	parent_node: null,
	children: []
};

const r6_d = {
	id: "r6_d",
	_id: "6d",
	title: "Light [Off]",
	parent_node: null,
	children: []
};

const r6_e = {
	id: "r6_e",
	_id: "6e",
	title: "Oven [Idle]",
	parent_node: null,
	children: []
};

nodes = add_nodes(nodes, [
	r6_a,
	r6_b,
	r6_c,
	r6_d,
	r6_e,
]);

add_child(r6_a, r6_b);
add_child(r6_b, r6_c);
add_child(r6_c, r6_d);
add_child(r6_d, r6_e);

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
	title: "Oven [Idle] (go up)",
	parent_node: null,
	children: []
};

add_child(r7_a, r7_b);
add_child(r7_b, r7_c);
add_child(r7_c, r7_d);
add_child(r7_d, r7_e);
add_child(r7_e, r7_f);

const r8_a = {
	id: "r8_a",
	_id: "8a",
	title: "User ???DoorOpen???",
	parent_node: null,
	children: []
};

const r8_b = {
	id: "r8_b",
	_id: "8b",
	title: "Door [Open]",
	parent_node: null,
	children: []
};

const r8_c = {
	id: "r8_c",
	_id: "8c",
	title: "Button [Disabled]",
	parent_node: null,
	children: []
};

const r8_d = {
	id: "r8_d",
	_id: "8d",
	title: "Oven [Open] (repeat)",
	parent_node: null,
	children: []
};

add_child(r8_a, r8_b);
add_child(r8_b, r8_c);
add_child(r8_c, r8_d);

const D = combine("D", r8_a, [
	r4_a,
	r8_b
]);


const B = combine("B", r1_d, [
	r1_e, 
	r2_a, 
	r4_c, 
	r5_a, 
	r7_a
]);


const E = combine("E", r5_b, [
	r3_c,
	r5_c
]);


const A = combine("A", r6_b, [
	r3_a,
	r6_c
]);

const C = combine("C", r6_d, [
	r1_a,
	r6_e
]);

nodes = nodes.concat([
	r1_a,
	r1_b,
	r1_c,
	r1_d,
	r1_e,

	r2_a,
	r2_b,
	r2_c,
	r2_d,
	r2_e,

	r3_a,
	r3_b,
	r3_c,
	r3_d,

	r4_a,
	r4_b,
	r4_c,
	r4_d,

	r5_a,
	r5_b,
	r5_c,
	r5_d,
	r5_e,
	r5_f,

	r7_a,
	r7_b,
	r7_c,
	r7_d,
	r7_e,
	r7_f,

	r8_a,
	r8_b,
	r8_c,
	r8_d,

	A,
	B,
	C,
	D,
	E,
]);


const	root = [
	r6_a
];

add_child(C, r8_a);

function add_nodes(nodes, node)
{
	return nodes.concat(node);
}

function combine(new_id, parent_node, nodes)
{
	let _id = nodes.reduce((acc,node) => {
		return String.raw`${acc}${node._id}\l`
	}, "");

	const title = nodes.reduce((acc,node) => {
		return node.title
	}, "");

	_id = String.raw`${_id}\l${new_id}`

	const new_node = {
		id: new_id,
		_id,
		title,
		children: []
	}

	nodes.forEach(node => {
		node.children.forEach(child => {
			add_child(new_node, child);
		});
	});

	parent_node.children = [ new_node ];
	new_node.parent_node = parent_node;

	return new_node;
}

function add_child(parent_node, child_node)
{
	child_node.parent_node = parent_node;
	parent_node.children = parent_node.children.concat(child_node)
}

function print_latex(root, parent_node, depth)
{
	if(parent_node === null)
	{
		const items = root.children.map(child => {
			const item = print_latex(child, root, depth + 1);
			return item;
		})

		return `\\node {${root.title}} ${items};`		
	}

	const isTerminalNode = root.children.length === 0;

	if(isTerminalNode)
	{
		return `child { node { ${root.title} } }`
	}

	const items = root.children.map(child => {
		const item = print_latex(child, root, depth + 1)
		return item;
	})

	return `child { node{${root.title}} ${items} }`		
}

const result = print_latex(root[0], null, 0);

console.log(result)
/*
	id: "r1_a",
	_id: "1a",
	title: "Oven [Idle]",
	parent_node: null,
	children: []
*/