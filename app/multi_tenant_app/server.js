const server = require("express");
const sql = require('yesql')('./sql/',  {type: 'pg', useNullForMissing: true})
const { Client } = require('pg')
const client = new Client({
    user: "user",
    password: "mysecretpassword",
    database: "postgres"
})

client
  .connect()
  .then(() => console.log('connected'))
  .catch(err => console.error('connection error', err.stack))

const app = server();
app.use(server.json());

app.post("/api/account/create_account", async (request, response) => {
    const payload = request.body;
    const headers = request.headers;

    const result = await createAccount(client, headers, payload);

    response.json(result);
})

app.post("/api/account/get_all_accounts", async (request, response) => {
    const body = request.body;
    console.log(body);
    console.log(request.headers);

    const result = await getAccounts(client);
    console.log(result)

    response.json(result);
})

app.listen("8080", (error) => {
    console.log("app started on 8080")
})

function createAccount(client, headers, payload)
{
    return new Promise((resolve, reject) => {
        // read from file and insert null values for missing parameters (price)
        client.query(sql.getAccounts(), (err, result) => {
            resolve(result.rows);
        })
    })
}

function getAccounts(client)
{
    return new Promise((resolve, reject) => {
        // read from file and insert null values for missing parameters (price)
        client.query(sql.getAccounts(), (err, result) => {
            resolve(result.rows);
        })
    })
}