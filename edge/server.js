const httpServer = require("./servers/http");

const server = httpServer.listen(8124, () => {
	console.info("Server is running on port 8124" );
});


