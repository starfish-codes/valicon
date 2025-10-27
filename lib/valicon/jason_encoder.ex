if Code.ensure_loaded?(Jason.Encoder) do
  require Protocol
  Protocol.derive(Jason.Encoder, Valicon.ValidationError)
  Protocol.derive(Jason.Encoder, Valicon.ConversionError)
end
