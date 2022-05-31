
const express = require("express");
const morgan = require("morgan");
const color = require("cli-color");
const swaggerJsDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");
const swaggerOptions = require("./swagger-options.json");
const { apiTokens } = require("./config");
const entities = require("./src/entities/entities.json");
const {
    defaultPort,
    hostUrl,
    basePath,
    publicFilesPath,
    pageNotFound } = require("./src/commons/variables");
const {
    httpSingleResponse, getLoginJwt, initDb } = require("./src/commons/functions");
const users = require("./src/routs/users");
const movies = require("./src/routs/movies");
const schedules = require("./src/routs/schedules");
const bookings = require("./src/routs/bookings");
const staffs = require("./src/routs/staffs");

require("dotenv").config();

(async () => {
    let dbInited =  await initDb();
    if(!dbInited) return;
    
    const app = express();

    let port = process.env.PORT || defaultPort;
    let hostUrlWithPort = `${hostUrl}:${port}`
    app.use(express.json());
    app.use(morgan("dev"));
    app.use((req, res, next) => {
        res.append("Access-Control-Allow-Origin", "*");
        res.append("Access-Control-Allow-Methods", "*");
        res.append("Access-Control-Allow-Headers", "*");
        next();
    });

    // swagger configs
    swaggerOptions.swaggerDefinition.servers.push(
        {
            url: hostUrlWithPort
        }
    )
    const swaggerDocs = swaggerJsDoc(swaggerOptions);
    app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocs));
    app.get("/entities", (req, res) => {
        res.end(JSON.stringify(entities))
    })
    app.use(express.static(publicFilesPath));

    app.use(basePath, (req, res, next) => {
        let token = req.params.token;
        if (!apiTokens.includes(token)) {
            httpSingleResponse(res, 400, "INVALID_TOKEN");
        } else next();
    })
    app.use(getLoginJwt);
    app.use(basePath + "/users", users);
    app.use(basePath + "/staffs", staffs);
    app.use(basePath + "/movies", movies);
    app.use(basePath + "/bookings", bookings);
    app.use(basePath + "/schedules", schedules);

    app.use((req, res) => {
        httpSingleResponse(res, 404, pageNotFound);
    })

    // @ts-ignore
    port = parseInt(port);
    console.log(color.magenta("Serving the app..."))
    app.listen(port, async () => {
        console.log(`App served at:`, color.blue(hostUrlWithPort));
        console.log(`Docs are found at:`, color.blue(`${hostUrlWithPort}/docs`));
        console.log(`Entities are found at:`, color.blue(`${hostUrlWithPort}/entities`));
        console.log()
    })
})()