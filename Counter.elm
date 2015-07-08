import Array
import Html exposing (button, div, span, text)
import Html.Events exposing (onClick)
import StartApp


main =
  StartApp.start { model = model, view = view, update = update }


model = Array.fromList [4,5,6]


view address model =
  div [] [
    div [] (Array.indexedMap (renderModelItem address) model |> Array.toList),
    span [] [ text ("Total " ++ (Array.foldl (+) 0 model |> toString)) ],
    button [ onClick address AddCounter ] [ text "add" ]
  ]

renderModelItem address index item =
  div [] [
    span [] [
      button [ onClick address (RemoveCounter index) ] [ text "x" ],
      text (toString item),
      button [ onClick address (ModifyCounter index -1) ] [ text "-" ],
      button [ onClick address (ModifyCounter index 1) ] [ text "+" ]
    ]
  ]


type Action = AddCounter | RemoveCounter Int | ModifyCounter Int Int

update action array =
  case action of

    AddCounter -> Array.push 0 array

    RemoveCounter index ->
      let length = Array.length array in
        Array.append (Array.slice 0 index array) (Array.slice (index + 1) length array)

    ModifyCounter index delta ->
      case Array.get index array of
        Nothing -> array
        Just item -> Array.set index (item + delta) array

    _ -> array
