use('zoo');
db.animales.insertMany(
    [{		
        "familia": "Aves",
		"animales": [{
				"nombre": "Garza Real",
				"ejemplares": ["Calíope", "Izaro"]
			}, {
				"nombre": "Cigüeña Blanca",
				"ejemplares": ["Perica", "Clara", "Miranda"]
			},
			{
				"nombre": "Gorrión",
				"ejemplares": ["coco", "roco", "loco", "peco", "rico"]
			}
		]
	},
	{	"familia": "Mamíferos",
		"animales": [{
				"nombre": "Zorro",
				"ejemplares": ["Lucas", "Mario"]
			}, {
				"nombre": "Lobo",
				"ejemplares": ["Pedro", "Pablo"]
			},
			{
				"nombre": "Ciervo",
				"ejemplares": ["Bravo", "Listo", "Rojo", "Astuto"]
			}
		]
	},
	{	"familia": "Peces",
		"animales": [{
				"nombre": "Globo",
				"ejemplares": ["Perico", "Loco", "Listo"]
			}, {
				"nombre": "Payaso",
				"ejemplares": ["Fofo", "Miliki"]
			},
			{
				"nombre": "Angel Llama",
				"ejemplares": ["Rodolfo", "Langostino"]
			}
		]
	}
]
);

use('zoo');
db.animales.findOne({"familia":"Peces"});

use('zoo');
db.animales.findOne({"familia":"Peces"}, {"animales": {$slice: 1}})

use('zoo');
db.animales.insertOne(
    {	
    "familia": "Reptiles",
	"animales": [{
			"nombre": "Lagartija",
			"ejemplares": ["Pan", "Pin", "Pon"]
		}, {
			"nombre": "Serpiente",
			"ejemplares": ["Fa", "Fe"]
		},
		{
			"nombre": "Tortuga",
			"ejemplares": ["Fita", "Tigra"]
		}
	]
}

);
use('zoo');
db.animales.findOne({"familia":"Reptiles"});

use('zoo');
db.animales.find().forEach((f) => {
    console.log(f.familia);
    f.animales.forEach((a) => {
        console.log("    " + a.nombre);
        console.log("           "+a.ejemplares);
    })

});

