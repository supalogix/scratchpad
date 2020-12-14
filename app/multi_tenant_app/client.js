const OpenAPIClientAxios = require('openapi-client-axios').default;
 
const api = new OpenAPIClientAxios({ 
    definition: './multi_tenant_app.yml',
    withServer: {
        url: 'http://localhost:8080'
    }
});

api.init()
    .then(client => client.getAllAccounts(
        {
            tenant_id: "1234"
        },
        {
            account_id: "asdf",
            username: "john.doe",
            password: "1234"
        },
    ))
    .then(res => console.log(res.data));