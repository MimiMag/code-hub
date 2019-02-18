const { GraphQLServer } = require('graphql-yoga')

// ILink = [{
//   id: ID,
//   url: String,
//   description: String
// }]

// const typeDefs = `
//   type Query {
//     info: String,
//     feed: [Link],
//   }
//   type Mutation {
//     addLink(url: String, description: String): Link!
//   }
//   type Link {
//     id: ID!,
//     url: String,
//     description: String
//   }
// `
const links = []
let counter = 1

const resolvers = {
  Query: {
    info: () => `Hello`,
    feed: () => links,
  },
  Mutation: {
    addLink: (_, args) => {
      const newLink =  {
        id: `${counter}`,
        description: args.description,
        url: args.url
      }
      counter++
      links.push(newLink)
      return newLink
    }
  }
}



const server = new GraphQLServer({
  typeDefs: "./src/schema.graphql",
  resolvers,
})

server.start(() => console.log(`server is running on localhost:4000`))
