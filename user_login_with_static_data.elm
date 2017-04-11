-- Read all about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/forms.html

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput,onClick)
import Markdown

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , emailCheck : String
  , statusValue : String
  }


model : Model
model =
  Model "" "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | EmailCheck String
    | Check


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }
    
    EmailCheck emailCheck ->
      { model | emailCheck = emailCheck }
    Check ->
      { model | statusValue = "something"  }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    
    [ 
    h1 [] [text "User Login"]
    , div [] [ text "Enter Email ID" ]
    , input [ type_ "text", placeholder "Enter email id", onInput EmailCheck ] []
    , div [] [ text "Enter Password" ]
    , input [ type_ "password", placeholder "Password", onInput Password ] [] 
    , viewValidation model
    , div [] [ text "Note => Email ID : admin@dq.com and Password : admin" ]
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == "admin" && model.emailCheck=="admin@dq.com" then
        ("green", "Correct Credentials")
      else if model.emailCheck=="admin@dq.com" && model.password /= "admin" then
        ("#E74C3C", "Correct Email ID! Wrong Password")
      else if model.emailCheck /="admin@dq.com" && model.password == "admin" then
        ("#E74C3C", "Wrong Email ID! Correct Password")
      else if model.emailCheck=="" && model.password =="" then
        ("#1C2833", "Please Enter Credentials")
      else
        ("red", "Wrong Credentials")

  in
    div [ style [("color", color),("font-size","20px")] ] [text message ]

