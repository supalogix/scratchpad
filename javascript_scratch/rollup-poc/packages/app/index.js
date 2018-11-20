import express from "express"

const app = express()

app.get("/", (request, response) => {
	response.json({
		key: "value2"
	})
})

export default app
