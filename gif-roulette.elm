import Html exposing (Html, div, h2, text, img, button, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode

main : Program Never Model Msg
main = 
    Html.program 
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Model = 
    { topic : String
    , gifUrl : String
    , alert : String
    }

type Msg
    = SetTopic String
    | MorePlease
    | NewGif (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetTopic str ->
            ({ model | topic = str }, Cmd.none)

        MorePlease ->
            ({ model | alert = "Loading..." }, getRandomGif model.topic)

        NewGif (Ok newUrl) ->
            ({ model | gifUrl = newUrl, alert = "" }, Cmd.none)

        NewGif (Err errMsg) ->
            ({ model | alert = (toString errMsg) }, Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , img [ src model.gifUrl ] []
        , div []
            [ button [ onClick MorePlease ] [ text "More Please" ]
            , input [ type_ "text", placeholder "Topic", onInput SetTopic ] []
            ]
        , div [] [ text model.alert ]
        ]

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

init : (Model, Cmd Msg)
init =
    (Model "1 Die" "images/die_1.png" "", Cmd.none)

getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request

decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at ["data", "image_url"] Decode.string