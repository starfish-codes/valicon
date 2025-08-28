defmodule Valicon.Currency do
  @moduledoc """
  Keeps the list of ISO4217 currency codes
  """

  @type t :: %{
          code: atom(),
          numeric_code: String.t(),
          decimals: integer(),
          name: String.t()
        }

  @list [
    %{
      code: :AED,
      numeric_code: "784",
      name: "UAE Dirham",
      decimals: 2
    },
    %{
      code: :AFN,
      numeric_code: "971",
      name: "Afghani",
      decimals: 2
    },
    %{
      code: :ALL,
      numeric_code: "008",
      name: "Lek",
      decimals: 2
    },
    %{
      code: :AMD,
      numeric_code: "051",
      name: "Armenian Dram",
      decimals: 2
    },
    %{
      code: :ANG,
      numeric_code: "532",
      name: "Netherlands Antillean Guilder",
      decimals: 2
    },
    %{
      code: :AOA,
      numeric_code: "973",
      name: "Kwanza",
      decimals: 2
    },
    %{
      code: :ARS,
      numeric_code: "032",
      name: "Argentine Peso",
      decimals: 2
    },
    %{
      code: :AUD,
      numeric_code: "036",
      name: "Australian Dollar",
      decimals: 2
    },
    %{
      code: :AWG,
      numeric_code: "533",
      name: "Aruban Florin",
      decimals: 2
    },
    %{
      code: :AZN,
      numeric_code: "944",
      name: "Azerbaijanian Manat",
      decimals: 2
    },
    %{
      code: :BAM,
      numeric_code: "977",
      name: "Convertible Mark",
      decimals: 2
    },
    %{
      code: :BBD,
      numeric_code: "052",
      name: "Barbados Dollar",
      decimals: 2
    },
    %{
      code: :BDT,
      numeric_code: "050",
      name: "Taka",
      decimals: 2
    },
    %{
      code: :BGN,
      numeric_code: "975",
      name: "Bulgarian Lev",
      decimals: 2
    },
    %{
      code: :BHD,
      numeric_code: "048",
      name: "Bahraini Dinar",
      decimals: 3
    },
    %{
      code: :BIF,
      numeric_code: "108",
      name: "Burundi Franc",
      decimals: 0
    },
    %{
      code: :BMD,
      numeric_code: "060",
      name: "Bermudian Dollar",
      decimals: 2
    },
    %{
      code: :BND,
      numeric_code: "096",
      name: "Brunei Dollar",
      decimals: 2
    },
    %{
      code: :BOB,
      numeric_code: "068",
      name: "Boliviano",
      decimals: 2
    },
    %{
      code: :BOV,
      numeric_code: "984",
      name: "Mvdol",
      decimals: 2
    },
    %{
      code: :BRL,
      numeric_code: "986",
      name: "Brazilian Real",
      decimals: 2
    },
    %{
      code: :BSD,
      numeric_code: "044",
      name: "Bahamian Dollar",
      decimals: 2
    },
    %{
      code: :BTN,
      numeric_code: "064",
      name: "Ngultrum",
      decimals: 2
    },
    %{
      code: :BWP,
      numeric_code: "072",
      name: "Pula",
      decimals: 2
    },
    %{
      code: :BYN,
      numeric_code: "933",
      name: "Belarussian Ruble",
      decimals: 0
    },
    %{
      code: :BZD,
      numeric_code: "084",
      name: "Belize Dollar",
      decimals: 2
    },
    %{
      code: :CAD,
      numeric_code: "124",
      name: "Canadian Dollar",
      decimals: 2
    },
    %{
      code: :CDF,
      numeric_code: "976",
      name: "Congolese Franc",
      decimals: 2
    },
    %{
      code: :CHE,
      numeric_code: "947",
      name: "WIR Euro",
      decimals: 2
    },
    %{
      code: :CHF,
      numeric_code: "756",
      name: "Swiss Franc",
      decimals: 2
    },
    %{
      code: :CHW,
      numeric_code: "948",
      name: "WIR Franc",
      decimals: 2
    },
    %{
      code: :CLF,
      numeric_code: "990",
      name: "Chilean Unidad de Fomento",
      decimals: 4
    },
    %{
      code: :CLP,
      numeric_code: "152",
      name: "Chilean Peso",
      decimals: 0
    },
    %{
      code: :CNY,
      numeric_code: "156",
      name: "Yuan Renminbi",
      decimals: 2
    },
    %{
      code: :COP,
      numeric_code: "170",
      name: "Colombian Peso",
      decimals: 2
    },
    %{
      code: :COU,
      numeric_code: "970",
      name: "Unidad de Valor Real",
      decimals: 2
    },
    %{
      code: :CRC,
      numeric_code: "188",
      name: "Costa Rican Colon",
      decimals: 2
    },
    %{
      code: :CUC,
      numeric_code: "931",
      name: "Peso Convertible",
      decimals: 2
    },
    %{
      code: :CUP,
      numeric_code: "192",
      name: "Cuban Peso",
      decimals: 2
    },
    %{
      code: :CVE,
      numeric_code: "132",
      name: "Cabo Verde Escudo",
      decimals: 2
    },
    %{
      code: :CZK,
      numeric_code: "203",
      name: "Czech Koruna",
      decimals: 2
    },
    %{
      code: :DJF,
      numeric_code: "262",
      name: "Djibouti Franc",
      decimals: 2
    },
    %{
      code: :DKK,
      numeric_code: "208",
      name: "Danish Krone",
      decimals: 2
    },
    %{
      code: :DOP,
      numeric_code: "214",
      name: "Dominican Peso",
      decimals: 2
    },
    %{
      code: :DZD,
      numeric_code: "012",
      name: "Algerian Dinar",
      decimals: 2
    },
    %{
      code: :EGP,
      numeric_code: "818",
      name: "Egyptian Pound",
      decimals: 2
    },
    %{
      code: :ERN,
      numeric_code: "232",
      name: "Nakfa",
      decimals: 2
    },
    %{
      code: :ETB,
      numeric_code: "230",
      name: "Ethiopian Birr",
      decimals: 2
    },
    %{
      code: :EUR,
      numeric_code: "978",
      name: "Euro",
      decimals: 2
    },
    %{
      code: :FJD,
      numeric_code: "242",
      name: "Fiji Dollar",
      decimals: 2
    },
    %{
      code: :FKP,
      numeric_code: "238",
      name: "Falkland Islands Pound",
      decimals: 2
    },
    %{
      code: :GBP,
      numeric_code: "826",
      name: "Pound Sterling",
      decimals: 2
    },
    %{
      code: :GEL,
      numeric_code: "981",
      name: "Lari",
      decimals: 2
    },
    %{
      code: :GHS,
      numeric_code: "936",
      name: "Ghana Cedi",
      decimals: 2
    },
    %{
      code: :GIP,
      numeric_code: "292",
      name: "Gibraltar Pound",
      decimals: 2
    },
    %{
      code: :GMD,
      numeric_code: "270",
      name: "Dalasi",
      decimals: 2
    },
    %{
      code: :GNF,
      numeric_code: "324",
      name: "Guinea Franc",
      decimals: 0
    },
    %{
      code: :GTQ,
      numeric_code: "320",
      name: "Quetzal",
      decimals: 2
    },
    %{
      code: :GYD,
      numeric_code: "328",
      name: "Guyana Dollar",
      decimals: 2
    },
    %{
      code: :HKD,
      numeric_code: "344",
      name: "Hong Kong Dollar",
      decimals: 2
    },
    %{
      code: :HNL,
      numeric_code: "340",
      name: "Lempira",
      decimals: 2
    },
    %{
      code: :HRK,
      numeric_code: "191",
      name: "Kuna",
      decimals: 2
    },
    %{
      code: :HTG,
      numeric_code: "332",
      name: "Gourde",
      decimals: 2
    },
    %{
      code: :HUF,
      numeric_code: "348",
      name: "Forint",
      decimals: 2
    },
    %{
      code: :IDR,
      numeric_code: "360",
      name: "Rupiah",
      decimals: 2
    },
    %{
      code: :ILS,
      numeric_code: "376",
      name: "New Israeli Sheqel",
      decimals: 2
    },
    %{
      code: :INR,
      numeric_code: "356",
      name: "Indian Rupee",
      decimals: 2
    },
    %{
      code: :IQD,
      numeric_code: "368",
      name: "Iraqi Dinar",
      decimals: 3
    },
    %{
      code: :IRR,
      numeric_code: "364",
      name: "Iranian Rial",
      decimals: 2
    },
    %{
      code: :ISK,
      numeric_code: "352",
      name: "Iceland Krona",
      decimals: 0
    },
    %{
      code: :JMD,
      numeric_code: "388",
      name: "Jamaican Dollar",
      decimals: 2
    },
    %{
      code: :JOD,
      numeric_code: "400",
      name: "Jordanian Dinar",
      decimals: 3
    },
    %{
      code: :JPY,
      numeric_code: "392",
      name: "Japanese Yen",
      decimals: 0
    },
    %{
      code: :KES,
      numeric_code: "404",
      name: "Kenyan Shilling",
      decimals: 2
    },
    %{
      code: :KGS,
      numeric_code: "417",
      name: "Kyrgyzstan Som",
      decimals: 2
    },
    %{
      code: :KHR,
      numeric_code: "116",
      name: "Cambodia Riel",
      decimals: 2
    },
    %{
      code: :KMF,
      numeric_code: "174",
      name: "Comoro Franc",
      decimals: 0
    },
    %{
      code: :KPW,
      numeric_code: "408",
      name: "North Korean Won",
      decimals: 2
    },
    %{
      code: :KRW,
      numeric_code: "410",
      name: "Korean Won",
      decimals: 0
    },
    %{
      code: :KWD,
      numeric_code: "414",
      name: "Kuwaiti Dinar",
      decimals: 3
    },
    %{
      code: :KYD,
      numeric_code: "136",
      name: "Cayman Islands Dollar",
      decimals: 2
    },
    %{
      code: :KZT,
      numeric_code: "398",
      name: "Tenge",
      decimals: 2
    },
    %{
      code: :LAK,
      numeric_code: "418",
      name: "Kip",
      decimals: 2
    },
    %{
      code: :LBP,
      numeric_code: "422",
      name: "Lebanese Pound",
      decimals: 2
    },
    %{
      code: :LKR,
      numeric_code: "144",
      name: "Sri Lanka Rupee",
      decimals: 2
    },
    %{
      code: :LRD,
      numeric_code: "430",
      name: "Liberian Dollar",
      decimals: 2
    },
    %{
      code: :LSL,
      numeric_code: "426",
      name: "Loti",
      decimals: 2
    },
    %{
      code: :LYD,
      numeric_code: "434",
      name: "Libyan Dinar",
      decimals: 3
    },
    %{
      code: :MAD,
      numeric_code: "504",
      name: "Moroccan Dirham",
      decimals: 2
    },
    %{
      code: :MDL,
      numeric_code: "498",
      name: "Moldovan Leu",
      decimals: 2
    },
    %{
      code: :MGA,
      numeric_code: "969",
      name: "Malagasy Ariary",
      decimals: 2
    },
    %{
      code: :MKD,
      numeric_code: "807",
      name: "Denar",
      decimals: 2
    },
    %{
      code: :MMK,
      numeric_code: "104",
      name: "Kyat",
      decimals: 2
    },
    %{
      code: :MNT,
      numeric_code: "496",
      name: "Tugrik",
      decimals: 2
    },
    %{
      code: :MOP,
      numeric_code: "446",
      name: "Pataca",
      decimals: 2
    },
    %{
      code: :MRU,
      numeric_code: "929",
      name: "Ouguiya",
      decimals: 2
    },
    %{
      code: :MUR,
      numeric_code: "480",
      name: "Mauritius Rupee",
      decimals: 2
    },
    %{
      code: :MVR,
      numeric_code: "462",
      name: "Rufiyaa",
      decimals: 2
    },
    %{
      code: :MWK,
      numeric_code: "454",
      name: "Kwacha",
      decimals: 2
    },
    %{
      code: :MXN,
      numeric_code: "484",
      name: "Mexican Peso",
      decimals: 2
    },
    %{
      code: :MXV,
      numeric_code: "979",
      name: "Mexican Unidad de Inversion (UDI)",
      decimals: 2
    },
    %{
      code: :MYR,
      numeric_code: "458",
      name: "Malaysian Ringgit",
      decimals: 2
    },
    %{
      code: :MZN,
      numeric_code: "943",
      name: "Mozambique Metical",
      decimals: 2
    },
    %{
      code: :NAD,
      numeric_code: "516",
      name: "Namibia Dollar",
      decimals: 2
    },
    %{
      code: :NGN,
      numeric_code: "566",
      name: "Naira",
      decimals: 2
    },
    %{
      code: :NIO,
      numeric_code: "558",
      name: "Cordoba Oro",
      decimals: 2
    },
    %{
      code: :NOK,
      numeric_code: "578",
      name: "Norwegian Krone",
      decimals: 2
    },
    %{
      code: :NPR,
      numeric_code: "524",
      name: "Nepalese Rupee",
      decimals: 2
    },
    %{
      code: :NZD,
      numeric_code: "554",
      name: "New Zealand Dollar",
      decimals: 2
    },
    %{
      code: :OMR,
      numeric_code: "512",
      name: "Rial Omani",
      decimals: 3
    },
    %{
      code: :PAB,
      numeric_code: "590",
      name: "Panama Balboa",
      decimals: 2
    },
    %{
      code: :PEN,
      numeric_code: "604",
      name: "Peruvian Nuevo Sol",
      decimals: 2
    },
    %{
      code: :PGK,
      numeric_code: "598",
      name: "Kina",
      decimals: 2
    },
    %{
      code: :PHP,
      numeric_code: "608",
      name: "Philippine Peso",
      decimals: 2
    },
    %{
      code: :PKR,
      numeric_code: "586",
      name: "Pakistan Rupee",
      decimals: 2
    },
    %{
      code: :PLN,
      numeric_code: "985",
      name: "Zloty",
      decimals: 2
    },
    %{
      code: :PYG,
      numeric_code: "600",
      name: "Guarani",
      decimals: 0
    },
    %{
      code: :QAR,
      numeric_code: "634",
      name: "Qatari Rial",
      decimals: 2
    },
    %{
      code: :RON,
      numeric_code: "946",
      name: "Romanian Leu",
      decimals: 2
    },
    %{
      code: :RSD,
      numeric_code: "941",
      name: "Serbian Dinar",
      decimals: 2
    },
    %{
      code: :RUB,
      numeric_code: "643",
      name: "Russian Ruble",
      decimals: 2
    },
    %{
      code: :RWF,
      numeric_code: "646",
      name: "Rwanda Franc",
      decimals: 0
    },
    %{
      code: :SAR,
      numeric_code: "682",
      name: "Saudi Riyal",
      decimals: 2
    },
    %{
      code: :SBD,
      numeric_code: "090",
      name: "Solomon Islands Dollar",
      decimals: 2
    },
    %{
      code: :SCR,
      numeric_code: "690",
      name: "Seychelles Rupee",
      decimals: 2
    },
    %{
      code: :SDG,
      numeric_code: "938",
      name: "Sudanese Pound",
      decimals: 2
    },
    %{
      code: :SEK,
      numeric_code: "752",
      name: "Swedish Krona",
      decimals: 2
    },
    %{
      code: :SGD,
      numeric_code: "702",
      name: "Singapore Dollar",
      decimals: 2
    },
    %{
      code: :SHP,
      numeric_code: "654",
      name: "Saint Helena Pound",
      decimals: 2
    },
    %{
      code: :SLE,
      numeric_code: "925",
      name: "Leone (new)",
      decimals: 2
    },
    %{
      code: :SLL,
      numeric_code: "694",
      name: "Sierra Leonean Leone (old)",
      decimals: 2
    },
    %{
      code: :SOS,
      numeric_code: "706",
      name: "Somali Shilling",
      decimals: 2
    },
    %{
      code: :SRD,
      numeric_code: "968",
      name: "Surinam Dollar",
      decimals: 2
    },
    %{
      code: :SSP,
      numeric_code: "728",
      name: "South Sudanese Pound",
      decimals: 2
    },
    %{
      code: :STN,
      numeric_code: "930",
      name: "Dobra",
      decimals: 2
    },
    %{
      code: :SVC,
      numeric_code: "222",
      name: "El Salvador Colon",
      decimals: 2
    },
    %{
      code: :SYP,
      numeric_code: "760",
      name: "Syrian Pound",
      decimals: 2
    },
    %{
      code: :SZL,
      numeric_code: "748",
      name: "Lilangeni",
      decimals: 2
    },
    %{
      code: :THB,
      numeric_code: "764",
      name: "Baht",
      decimals: 2
    },
    %{
      code: :TJS,
      numeric_code: "972",
      name: "Somoni",
      decimals: 2
    },
    %{
      code: :TMT,
      numeric_code: "934",
      name: "Turkmenistan New Manat",
      decimals: 2
    },
    %{
      code: :TND,
      numeric_code: "788",
      name: "Tunisian Dinar",
      decimals: 3
    },
    %{
      code: :TOP,
      numeric_code: "776",
      name: "Pa�anga",
      decimals: 2
    },
    %{
      code: :TRY,
      numeric_code: "949",
      name: "Turkish Lira",
      decimals: 2
    },
    %{
      code: :TTD,
      numeric_code: "780",
      name: "Trinidad and Tobago Dollar",
      decimals: 2
    },
    %{
      code: :TWD,
      numeric_code: "901",
      name: "New Taiwan Dollar",
      decimals: 2
    },
    %{
      code: :TZS,
      numeric_code: "834",
      name: "Tanzanian Shilling",
      decimals: 2
    },
    %{
      code: :UAH,
      numeric_code: "980",
      name: "Hryvnia",
      decimals: 2
    },
    %{
      code: :UGX,
      numeric_code: "800",
      name: "Uganda Shilling",
      decimals: 0
    },
    %{
      code: :USD,
      numeric_code: "840",
      name: "US Dollar",
      decimals: 2
    },
    %{
      code: :USN,
      numeric_code: "997",
      name: "US Dollar (Next day)",
      decimals: 2
    },
    %{
      code: :UYI,
      numeric_code: "940",
      name: "Uruguay Peso en Unidades Indexadas (URUIURUI)",
      decimals: 0
    },
    %{
      code: :UYU,
      numeric_code: "858",
      name: "Peso Uruguayo",
      decimals: 2
    },
    %{
      code: :UYW,
      numeric_code: "927",
      name: "Unidad Previsional",
      decimals: 4
    },
    %{
      code: :UZS,
      numeric_code: "860",
      name: "Uzbekistan Sum",
      decimals: 2
    },
    %{
      code: :VED,
      numeric_code: "926",
      name: "Venezuelan Bolivar digital",
      decimals: 2
    },
    %{
      code: :VES,
      numeric_code: "928",
      name: "Venezuelan Bolivar soberano",
      decimals: 2
    },
    %{
      code: :VND,
      numeric_code: "704",
      name: "Vietnamese Dong",
      decimals: 0
    },
    %{
      code: :VUV,
      numeric_code: "548",
      name: "Vatu",
      decimals: 0
    },
    %{
      code: :WST,
      numeric_code: "882",
      name: "Tala",
      decimals: 2
    },
    %{
      code: :XAG,
      numeric_code: "961",
      name: "Silver",
      decimals: 0
    },
    %{
      code: :XAF,
      numeric_code: "950",
      name: "CFA Franc BEAC",
      decimals: 0
    },
    %{
      code: :XAU,
      numeric_code: "959",
      name: "Gold",
      decimals: 0
    },
    %{
      code: :XBA,
      numeric_code: "955",
      name: "European Composite Unit (EURCO)",
      decimals: 0
    },
    %{
      code: :XBB,
      numeric_code: "956",
      name: "European Monetary Unit (E.M.U.-6)",
      decimals: 0
    },
    %{
      code: :XBC,
      numeric_code: "957",
      name: "European Unit of Account 9 (E.U.A.-9)",
      decimals: 0
    },
    %{
      code: :XBD,
      numeric_code: "958",
      name: "European Unit of Account 17 (E.U.A.-17)",
      decimals: 0
    },
    %{
      code: :XCD,
      numeric_code: "951",
      name: "East Caribbean Dollar",
      decimals: 2
    },
    %{
      code: :XDR,
      numeric_code: "960",
      name: "SDR (Special Drawing Right)",
      decimals: 2
    },
    %{
      code: :XOF,
      numeric_code: "952",
      name: "CFA Franc BCEAO",
      decimals: 0
    },
    %{
      code: :XPD,
      numeric_code: "964",
      name: "Palladium (one troy ounce)",
      decimals: 0
    },
    %{
      code: :XPF,
      numeric_code: "953",
      name: "CFP Franc",
      decimals: 0
    },
    %{
      code: :XPT,
      numeric_code: "962",
      name: "Platinum (one troy ounce)",
      decimals: 0
    },
    %{
      code: :XSU,
      numeric_code: "994",
      name: "Sucre",
      decimals: 2
    },
    %{
      code: :XTS,
      numeric_code: "963",
      name: "Code reserved for testing",
      decimals: 0
    },
    %{
      code: :XUA,
      numeric_code: "965",
      name: "ADB Unit of Account",
      decimals: 2
    },
    %{
      code: :XXX,
      numeric_code: "999",
      name: "no currency",
      decimals: 0
    },
    %{
      code: :YER,
      numeric_code: "886",
      name: "Yemeni Rial",
      decimals: 2
    },
    %{
      code: :ZAR,
      numeric_code: "710",
      name: "Rand",
      decimals: 2
    },
    %{
      code: :ZMW,
      numeric_code: "967",
      name: "Zambian Kwacha",
      decimals: 2
    },
    %{
      code: :ZWL,
      numeric_code: "932",
      name: "Zimbabwe Dollar",
      decimals: 2
    }
  ]

  @codes Enum.map(@list, & &1.code)
  @strings Enum.map(@codes, &Atom.to_string/1)

  @spec valid_code?(String.t()) :: boolean()
  def valid_code?(code) when is_binary(code), do: Enum.member?(@strings, code)
  def valid_code?(_code), do: false
end
