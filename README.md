# elm-play
Learning the Elm language

## Resources
- [Elm website](http://elm-lang.org/) (install)
- [Official Elm guide](https://guide.elm-lang.org/) (better)
  - [Direct Download (PDF)](https://www.gitbook.com/download/pdf/book/evancz/an-introduction-to-elm) (ok)


## Tooling and basics of coding
I'm using [Visual Studio Code][editor] editor with the [`elm` plugin][plugin] by **Sascha Brink**. In it you can type inside a `.elm` file 
``` Elm
Html.program
```
and hit tab to be welcomed by a basic template (while typing look for the hint given for auto-completing, just below the cursor).

[editor]: https://code.visualstudio.com/ "VS Code"
[plugin]: https://github.com/Krzysztof-Cieslak/vscode-elm "Elm plugin"


A little bit of tuning in
  - [x] **Model** type
  - [x] **Msg** type
  - [x] **update** function
  - [x] **view** function
  - [x] **init** call

and you can contemplate your own Elm web app (or page?). Of course that you can further tune the code customizing all those parts and the subscriptions function.

---

Template example (as of `2017-06-16`)
``` Elm
-- some_elm_file.elm

module Name exposing (Model, Msg, update, view, subscriptions, init)


import Html exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


type alias Model =
    { property : propertyType
    }


type Msg
    = msg1
    | msg2


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        msg1 ->
            (model, Cmd.none)

        msg2 ->
            (model, Cmd.none)


view : Model -> Html Msg
view model =
    div []
        [ text "New Html Program"
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    (Model modelInitialValue, Cmd.none)

```
