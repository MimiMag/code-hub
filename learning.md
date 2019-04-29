# code-hub

In this repo, we'll build a full stack simple app from scratch and deploy it to learn all about the different technologies we are using.
Our first feature will be displaying a list of links of [hackernews](https://news.ycombinator.com/), later we might add more features.

![happy face](https://cd.sseu.re/Quizzz__Codaisseur_Reader_v3.0_2019-02-18_16-48-37.png)

Steps we will take:
1. Create A Simple GraphQL Server - using `graphql-yoga`
2. Add a database, using prisma as ORM
3. Build a client, using `apollo-graphql`
4. Set up continuous deployment

## 1. A SIMPLE GRAPHQL SERVER
src: [HowToGraphQL (_Introduction - Simple Mutation_)](https://www.howtographql.com/graphql-js/0-introduction/)
![graphql logo](https://cdn-images-1.medium.com/max/1200/1*RHQ7lpGDV_M3yWRa9DiR2g.png)

### Pre-requisites
* You need to know what a server is
    * For this step, we'll just define a server as anything that deals with requests and sends out some sort of responses. Our server should allow us to retreive and modify data.
* You need to know the two advantages of GraphQL
    * GraphQL allows us to define clear interfaces to communicate between apis
    * GraphQL allows us (on the client side) to query for multiple models in one request
* You need to know that you use a `query` to retreive some data and a `mutation` to modify data
    
 ### Learning Goals
 By the end of this step, you will understand that...
 * you can set up a graphql-server by calling a new instance of _**GraphQLServer**_ (provided by `graphql-yoga`)
 * the GraphQLServer constructor takes two arguments: `typeDefs` & `resolvers`.
 * **typedefs** are an interface to explain to the outside world what our data looks like and how it can be changed
 * typedefs are also called a **schema**
 * **resolvers** are key value pairs that contain the logic (functions) to actually return the data
 
 ### Steps
 See: [HowToGraphQL (_Introduction - Simple Mutation_)](https://www.howtographql.com/graphql-js/0-introduction/)

 > "_Give me some typeDefs and Resolvers, and I'll make it work_" - Graphql-Yoga
 
 ## 2. Setting Up TypeScript and Prisma
 src: [HowToGraphQL (_Adding A Database_)](https://www.howtographql.com/graphql-js/4-adding-a-database/), [Readest (Typescript 1)](https://readest.codaisseur.com/courses/advanced-bootcamp/06-typescript/typescript-tools), [Set Up Prisma](https://www.prisma.io/docs/1.26/get-started/01-setting-up-prisma-new-database-TYPESCRIPT-t002/), [Prisma Datamodel](https://www.prisma.io/docs/1.27/datamodel-and-migrations/datamodel-POSTGRES-knum/)
 
 ![postgres and prisma](https://i.imgur.com/yEsyfKh.png)
 
 ### Pre-requisites
 * You need to know what a database is and that Postgres
      * A database is a collection of information that is organized so that it can be easily accessed, managed and updated.
      * PostgreSQL is a powerful, open source object-relational database system
 * You need to know what docker is a tool designed to make it easier to create, deploy, and run applications (such as a postgres db) by using containers. 
 * You need to know that you use a `query` to retreive some data and a `mutation` to modify data
 
 
 ### Learning Goals
 By the end of this step you will understand:
 
 * That you'll need to add the `typescript` dependency and some configuration in a `tsconfig.json` file to make sure your code gets compiled, such as which files need to be compiled and special set up for using libraries.
 * How to configure a `nodemon.json`-file to use the `ts-node` and `nodemon` dependencies to create a seamless compilation process.
  * That prisma sets up a layer between your GraphQL Server and the Database so you don't need to deal with SQL or ORMs in your resolvers.
 * How to set a up a postgres database through a `docker-compose.yml`
 * How to create a `prisma.yml`-file and a `datamodel` to set up prisma in your app
 * How to `deploy` prisma to create tables in your database and generate some basic queries/mutations available on our prisma endpoint.
 * How to run `prisma generate` to add files with the logic to create these queries/mutation to our app, so we can reuse it.
 ![generate from model](https://cd.sseu.re/Datamodel_MySQL_-_Prisma_Docs_2019-03-04_13-45-48.png)
 
 ## 3. Connecting Prisma to our GraphQl Server
 ![context](https://cdn.worldvectorlogo.com/logos/context.svg)
 src: [how to graphql](https://www.howtographql.com/graphql-js/5-connecting-server-and-database/)
 
 ### Pre-requisites
 * The info above
 * That `seeds` are dummy data, used to populate your database.
 
 ### Learning Goals
 By the end of this step you will understand...
 
 * How to connect your Prisma Server to your home-made graphql server using the `context` argument in the resolvers.
 * How to populate your database using `seeds` in `prisma`.
 
 ### 3.1. Environmental Variables
 Environmental variables are an important part of creating a more flexible code when it comes to setting up a project.

 There reasons to use want to use environmental variables:
 * Maybe you want to start your process twice.
 * Maybe you want to connect to a server on another computer.
 * Storing values you use on multiple places all around the code for example API keys.
 * etc

 Resolving:
 * You cant start your server twice on the same address because its already in use.
 * Connecting to another server is easily done by simply overwriting the value.
 * Secret API keys should **never** be part of your source code, as this is sensitive data and subject to change.

 Concept:
 * The basic concept is to make a `.env` file in the root of your project and 1 variable per line `PORT=4000`.
 * Use `process.env.PORT` in the code to reffer to that value when you create your server.
 * Overwrite this value when needed when starting your application when needed `PORT=4001 yarn start`.

 ## 3.1.1 Setting up Environmental Variables
 In this example we use the package [`dotenv-cli`](https://www.npmjs.com/package/dotenv-cli).

 * Add it to your dev dependencies: `yarn add dotenv-cli -D`
 * Edit your `package.json` script to run :
  ```
    "scripts": {
      "dev": "dotenv -- nodemon",
      etc...
  ```
 * Create a `.env` file in the root directory of your project (same level as `package.json`)
 * **VERY IMPORTANT**: add `.env` to your `.gitignore`:
  * By adding it manually or 
  * Be fancy and use a command: `echo ".env" >> .gitignore`
 * Defining variables:
  ```
  IP=localhost
  PORT=4000
  SCHEMA=http
  SERVER=${SCHEMA}://${IP}:${PORT}
  ```
 
 [`dotenv-cli`](https://www.npmjs.com/package/dotenv-cli) allows us to reuse values while defining them, something a simular package like [`dotenv`](https://www.npmjs.com/package/dotenv) does not provide.

 ### 3.1.2 Using Environmental Variables
 To run your application on a different port, simply do: `PORT=4001 yarn start`
 And `console.log(process.env.SERVER)` should automatically be updated to use the new port number.

 ## 4. Building a front end with React-Apollo
 
 ### Pre-requisites
 
 ### Learning Goals
 ![Architecture](https://cd.sseu.re/Getting_Started_with_GraphQL_React__Apollo_Tutorial_2019-03-04_14-12-33.png)
 
