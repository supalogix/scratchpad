const r1_a = {
	id: "r1_a",
	group: "R1",
	title: "Oven [Idle]"
};

const r1_b = {
	id: "r1_b",
	group: "R1",
	title: "User ???PushButton???"
};

const r1_c = {
	id: "r1_c",
	group: "R1",
	title: "Button [Pushed]"
};

const r1_d = {
	id: "r1_d",
	group: "R1",
	title: "Powertube [Energized]"
};

const r1_e = {
	id: "r1_e",
	group: "R1",
	title: "Oven [Cooking]"
};

r1_a.children = [r1_b];
r1_b.children = [r1_c];
r1_c.children = [r1_d];
r1_d.children = [r1_e];
r1_e.children = [];

const r2_a = {
	id: "r2_a",
	group: "R2",
	title: "Oven [Cooking]"
};

const r2_b = {
	id: "r2_b",
	group: "R2",
	title: "User ???PushButton???"
};

const r2_c = {
	id: "r2_c",
	group: "R2",
	title: "Button [Pushed]"
};

const r2_d = {
	id: "r2_d",
	group: "R2",
	title: "Oven [ExtraMin]"
};

const r2_e = {
	id: "r2_e",
	group: "R2",
	title: "Oven [Cooking]"
};

r2_a.children = [r2_b];
r2_b.children = [r2_c];
r2_c.children = [r2_d];
r2_d.children = [r2_e];
r2_e.children = [];

const r3_a = {
	id: "r3_a",
	group: "R3",
	title: "Door [Closed]"
}

const r3_b = {
	id: "r3_b",
	group: "R3",
	title: "Button [Enabled]"
}

const r3_c = {
	id: "r3_c",
	group: "R3",
	title: "Door [Open]"
}


const r3_d = {
	id: "r3_d",
	group: "R3",
	title: "Button [Disabled]"
}


r3_a.children = [r3_b];
r3_b.children = [];
r3_c.children = [r3_d];
r3_d.children = [];

const r4_a = {
	id: "r4_a",
	group: "R4",
	title: "Door [Open]"
}

const r4_b = {
	id: "r4_b",
	group: "R4",
	title: "Light [On]"
}

const r4_c = {
	id: "r4_c",
	group: "R4",
	title: "Oven [Cooking]"
}


const r4_d = {
	id: "r4_d",
	group: "R4",
	title: "Light [On]"
}


r4_a.children = [r4_b];
r4_b.children = [];
r4_c.children = [r4_d];
r4_d.children = [];

const r5_a = {
	id: "r5_a",
	group: "R5",
	title: "Oven [Cooking]"
};

const r5_b = {
	id: "r5_b",
	group: "R5",
	title: "User ???DoorOpen???",
};

const r5_c = {
	id: "r5_c",
	group: "R5",
	title: "Door [Open]",
};

const r5_d = {
	id: "r5_d",
	group: "R5",
	title: "Powertube [Off]",
};

const r5_e = {
	id: "r5_e",
	group: "R5",
	title: "Oven [CookStop]",
};

const r5_f = {
	id: "r5_f",
	group: "R5",
	title: "Oven [Open]",
};

r5_a.children = [r5_b];
r5_b.children = [r5_c];
r5_c.children = [r5_d];
r5_d.children = [r5_e];
r5_e.children = [r5_f];
r5_e.children = [];

const r6_a = {
	id: "r6_a",
	group: "R6",
	title: "Oven [Open]"
};

const r6_b = {
	id: "r6_b",
	group: "R6",
	title: "User ???DoorClosed???",
};

const r6_c = {
	id: "r6_c",
	group: "R6",
	title: "Door [Closed]",
};

const r6_d = {
	id: "r6_d",
	group: "R6",
	title: "Light [Off]",
};

const r6_e = {
	id: "r6_e",
	group: "R6",
	title: "Oven [Idle]",
};

r6_a.children = [r6_b];
r6_b.children = [r6_c];
r6_c.children = [r6_d];
r6_d.children = [r6_e];
r6_e.children = [];

const r7_a = {
	id: "r7_a",
	group: "R7",
	title: "Oven [Cooking]"
};

const r7_b = {
	id: "r7_b",
	group: "R7",
	title: "Oven ???TimeOut???",
};

const r7_c = {
	id: "r7_c",
	group: "R7",
	title: "Light [Off]",
};

const r7_d = {
	id: "r7_d",
	group: "R7",
	title: "Powertube [Off]",
};

const r7_e = {
	id: "r7_e",
	group: "R7",
	title: "Beeper [Sounded]",
};

const r7_f = {
	id: "r7_f",
	group: "R7",
	title: "Oven [CookFinish]",
};

const r7_g = {
	id: "r7_g",
	group: "R7",
	title: "Oven ^[Idle]",
};

r7_a.children = [r7_b];
r7_b.children = [r7_c];
r7_c.children = [r7_d];
r7_d.children = [r7_e];
r7_e.children = [r7_f];
r7_f.children = [];

const r8_a = {
	id: "r8_a",
	title: "User ???DoorOpen???"
};

const r8_b = {
	id: "r8_b",
	title: "Door [Open]",
};

const r8_c = {
	id: "r8_c",
	title: "Button [Disabled]",
};

const r8_d = {
	id: "r8_d",
	title: "Oven ^[Open]",
};

r8_a.children = [r8_b];
r8_b.children = [r8_c];
r8_c.children = [r8_d];
r8_d.children = [];

const nodes = [
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

	r6_a,
	r6_b,
	r6_c,
	r6_d,
	r6_e,

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
];

const r6 = {
	node: {
		[r6_a.id]: r6_a,
		[r6_b.id]: r6_b,
		[r6_c.id]: r6_c,
		[r6_d.id]: r6_d,
		[r6_e.id]: r6_e,
	},
	root: [
		r6_a
	]
};

append(r6_b, r3_a);
append(r6_d, r1_a);
append(r1_d, r2_a);
append(r1_d, r5_a);
append(r5_b, r3_c);
append(r1_d, r7_a);
append(r1_a, r8_a);
append(r8_a, r4_a);

append(r1_e, r4_c);
append(r2_a, r4_c);
append(r5_a, r4_c);
append(r7_a, r4_c);

function append(lhs, rhs)
{
	lhs.children = lhs.children.concat(rhs)
}

function get_names(nodes)
{
	nodes.forEach(node => {
		const {
			id, 
			title,
			group
		}  = node

		const label = String.raw`!$${id} = '"${title}\l${id}"'`

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
get_relationships(r6.root, null);

