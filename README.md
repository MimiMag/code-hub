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
