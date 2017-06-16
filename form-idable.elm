module FormIdable exposing (Model, Msg, update, view, subscriptions, init)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Regex exposing (regex, contains)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    -- , validate : Bool
    , color : String
    , message : String
    }


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Submit


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        -- Name name ->
        --     ({ model | name = name, validate = False }, Cmd.none)

        -- Password password ->
        --     ({ model | password = password, validate = False }, Cmd.none)

        -- PasswordAgain password ->
        --     ({ model | passwordAgain = password, validate = False }, Cmd.none)

        -- Age age ->
        --     ({ model | age = age, validate = False }, Cmd.none)
        
        -- Age age ->
        --     ( { model | age = 
        --         (case (String.toInt age) of
        --             Err msg ->
        --                 model.age
                    
        --             Ok age ->
        --                 age
        --         ) }, Cmd.none)

        -- Submit ->
        --     ({ model | validate = True }, Cmd.none)
        Name name ->
            ({ model | name = name }, Cmd.none)

        Password password ->
            ({ model | password = password }, Cmd.none)

        PasswordAgain password ->
            ({ model | passwordAgain = password }, Cmd.none)

        Age age ->
            ({ model | age = age }, Cmd.none)

        Submit ->
            let (color, message) = 
                if (String.length model.password) < 8 then
                    ("red", "Password must be at least 8 characters long.")
                else if contains (regex "[A-Z]") model.password == False then
                    ("red", "Password must contain at least 1 upper case letter")
                else if contains (regex "[a-z]") model.password == False then
                    ("red", "Password must contain at least 1 lower case letter")
                else if contains (regex "[0-9]") model.password == False then
                    ("red", "Password must contain at least 1 number")
                else if model.password == model.passwordAgain then
                    case (String.toInt model.age) of
                        Err msg -> ("red", "Age must be a number.")

                        Ok age ->
                                ("green", "OK")
                else
                    ("red", "Passwords do not match!")
            in
                ({ model | color = color, message = message }, Cmd.none)



view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Re-type your password", onInput PasswordAgain ] []
        , input [ type_ "text", placeholder (toString model.age), onInput Age ] []
        , button [ onClick Submit ] [ text "Submit" ]
        , div [ style [("color", model.color)] ] [ text model.message ]
        -- , viewValidation model
        ]

-- viewValidation : Model -> Html msg
-- viewValidation model =
--     let
--         (color, message) =
--             if model.validate == False then
--                 (model.color, model.message)
--             else if (String.length model.password) < 8 then
--                 ("red", "Password must be at least 8 characters long.")
--             else if contains (regex "[A-Z]") model.password == False then
--                 ("red", "Password must contain at least 1 upper case letter")
--             else if contains (regex "[a-z]") model.password == False then
--                 ("red", "Password must contain at least 1 lower case letter")
--             else if contains (regex "[0-9]") model.password == False then
--                 ("red", "Password must contain at least 1 number")
--             else if model.password == model.passwordAgain then
--                 case (String.toInt model.age) of
--                     Err msg -> ("red", "Age must be a number.")

--                     Ok age ->
--                             ("green", "OK")
--             else
--                 ("red", "Passwords do not match!")
--     in
--         div [ style [("color", color)] ] [ text message ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    ( Model "" "" "" "" "" "start", Cmd.none)
    -- ( Model "" "" "" "" False "" "start", Cmd.none)
