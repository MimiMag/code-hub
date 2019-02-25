const { GraphQLServer } = require('graphql-yoga')

interface IArgs {
  description: string,
  url: string,
}

interface ILink {
  description: string,
  url: string,
  id: string
}

const links: ILink[] = []
let counter = 1

const resolvers = {
  Query: {
    info: () => `Hello`,
    feed: () => links,
  },
  Mutation: {
    addLink: (_:any, args:IArgs) => {
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
