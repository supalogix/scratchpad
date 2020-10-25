const r6 = {
	requirement_id: "R6",
	component: {
		a: {
			title: "Oven [Open]"
		},
		b: {
			component: "User ???DoorClosed???",
		},
		c: {
			component: "Door [Closed]",
		},
		d: {
			component: "Light [Off]",
		},
		e: {
			component: "Oven [Idle]",
		},
	},
	relation: {
		a: "b",
		b: "c",
		c: "d",
		d: "e"
	},
	start: [
		"a"
	]
};

const r3 = {
	requirement_id: "R3",
	component: {
		a: {
			title: "Door [Closed]",
		},
		b: {
			title: "Button [Enabled]",
		},
		c: {
			title: "Door [Open]",
		},
		d: {
			title: "Button [Disabled]",
		}
	},
	relation: {
		a: ["b"],
		c: ["d"]
	},
	start: [
		"a",
		"c"
	]
};

const ibt = {
	component: {
		a: [r6, "a"],
		b: [r6, "b"],
		c: [
			[r6, "c"],
			[r3, "a"]
		],
		d: [r6, "d"],
		e: [r6, "e"],
		f: [r3, "b"]
	},
	relation: {
		a: "b",
		b: "c",
		c: [
			"d",
			"f"
		],
		d: "e"
	},
	start: [
		"a"
	]
};

const create_rbt_variables = (requirement) => {
	const keys = Object.keys(requirement.component);
	const {
		requirement_id,
		component
	} = requirement

	console.log(component)
	console.log(requirement)

	const items = []

	console.log(keys);

	keys.forEach(key => {
		console.log(key)
		const { title } = component[key]
		items.push({
			id: key,
			title: String.raw`${title}\l${requirement_id}\l${key}`
		})
	});

	return items;
}

const create_rbt_relations = (requirement) => {
	let stack = [...requirement.start];

	while(stack.length > 0)
	{
		console.log(`stack: ${stack}`)
		const item = stack.pop();

		console.log(`item: ${item}`)

		if(!item)
			break

		const relations = requirement.relation[item]
		if(relations)
		{
			stack = relations.concat(stack)
		}
	}


};

create_rbt_variables(r3).forEach(item => {
	const line = `!$${item.id} = '"${item.title}"'`
	console.log(line);
});

create_rbt_relations(r3);
