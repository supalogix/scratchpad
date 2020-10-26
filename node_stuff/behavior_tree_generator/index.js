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

addChild(r1_a, r1_b);
addChild(r1_b, r1_c);
addChild(r1_c, r1_d);
addChild(r1_d, r1_e);

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

addChild(r2_a, r2_b);
addChild(r2_b, r2_c);
addChild(r2_c, r2_d);
addChild(r2_d, r2_e);


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

addChild(r3_a, r3_b);
addChild(r3_c, r3_d);

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

addChild(r4_a, r4_b);
addChild(r4_c, r4_d);

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


addChild(r5_a, r5_b);
addChild(r5_b, r5_c);
addChild(r5_c, r5_d);
addChild(r5_d, r5_e);
addChild(r5_e, r5_f);

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

addChild(r6_a, r6_b);
addChild(r6_b, r6_c);
addChild(r6_c, r6_d);
addChild(r6_d, r6_e);

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

addChild(r7_a, r7_b);
addChild(r7_b, r7_c);
addChild(r7_c, r7_d);
addChild(r7_d, r7_e);
addChild(r7_e, r7_f);

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
	title: "Oven ^[Open]",
	parent_node: null,
	children: []
};

addChild(r8_a, r8_b);
addChild(r8_b, r8_c);
addChild(r8_c, r8_d);

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

addChild(C, r8_a);

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
			addChild(new_node, child);
		});
	});

	parent_node.children = [ new_node ];
	new_node.parent_node = parent_node;

	return new_node;
}

function addChild(parent_node, child_node)
{
	child_node.parent_node = parent_node;
	parent_node.children = parent_node.children.concat(child_node)
}

function get_names(nodes)
{
	nodes.forEach(node => {
		const {
			id, 
			_id,
			title,
		}  = node

		const label = String.raw`!$${id} = '"${title}\l\l${_id}"'`

		console.log(label);

	});
}

function get_relationships(root, parent_node)
{
	const isTerminalNode = root.length === 0;

	if(isTerminalNode)
		return

	const isRootNode = parent_node === null;

	if(isRootNode)
	{
		root.forEach(node => {
			const relation = `(*) --> $${node.id}`
			console.log(relation);
			get_relationships(node.children, node);
		});
	}
	else
	{
		root.forEach(node => {
			const relation = `$${parent_node.id} --> $${node.id}`
			console.log(relation);
			get_relationships(node.children, node);
		});
	}
}

get_names(nodes);
get_relationships(root, null);

