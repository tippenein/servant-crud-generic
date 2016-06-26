servant-crud-generic
-----
[![Build Status](https://magnum.travis-ci.com/tippenein/servant-crud-generic.svg?token=oEd198sTq2JwZqn9DHTF&branch=master)](https://magnum.travis-ci.com/tippenein/servant-crud-generic)

Servant Crud Generic should take a data type and build the necessary API with CRUD capabilities.

There are 2 ways that I can think of to do this. One is via code-generation and
the other is by finagling some type class to do the work for us.

For example given this data type:

```haskell

data User = User {
    id             :: Int
  , email          :: Text
  , first_name     :: Text
  , last_name      :: Text
  , dob            :: Day
  } deriving (Show, Generic, ToJSON, FromJSON)
```

You might generate some API functionality similar to this:

```haskell
data UsersResponse = UsersResponse {
  users :: [User]
  } deriving (Show, Generic, FromJSON, ToJSON)

type UserAPI =
       GetUsers
  :<|> GetUser
  :<|> CreateUser
  :<|> UpdateUser
  :<|> DestroyUser


type GetUsers = "user" :> "users"
    :> QueryParam "id" Int
    :> QueryParam "email" Text
    :> Get '[JSON] UsersResponse

type GetUser = "user" :> "users"
    :> Capture "id" Integer
    :> Get '[JSON] User

type CreateUser =  "user" :> "users"
    :> ReqBody '[JSON] User
    :> Post '[JSON] User

type UpdateUser = "user" :> "users"
    :> Capture "id" Integer
    :> ReqBody '[JSON] User
    :> Put '[JSON] User

type DestroyUser = "user" :> "users"
    :> Capture "id" Integer
    :> Delete '[JSON] User
```

### Configure & build the package.
stack build

### Test package.
stack test
