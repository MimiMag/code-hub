const { GraphQLServer } = require('graphql-yoga')
const { prisma } = require('../prisma/generated/prisma-client')

interface IArgs {
  description: string,
  url: string,
}

const resolvers = {
  Query: {
    info: () => `Hello`,
    feed: (_:any, _args:any, context: any) => {
      return context.db.links()
    },
  },
  Mutation: {
    addLink: (_: any, args: IArgs, context: any) => {
      return context.db.createLink({ url: args.url, description: args.description}) 
    }
  }
}

const server = new GraphQLServer({
  typeDefs: "./src/schema.graphql",
  resolvers,
  context: { db: prisma }
})

server.start(() => console.log(`server is running on localhost:4000`))
