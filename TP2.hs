	module TP2 where
	import Text.Show.Functions
	import Data.List

	--1

	{--
			Utilizamos datas con el fin de obtener los getters de los campos para el tipo de dato
			e intentamos elegir los nombres mas descriptivos para cada tipo de dato


	--}




	data Cliente = UnCliente {nombre :: String,resistencia :: Int,amigos :: [Cliente], tragosQueTomo :: [Bebida]} deriving (Show)


	--2


	rodri :: Cliente
	rodri = UnCliente "Rodrigo" 55 [] [tintico]

	marcos :: Cliente
	marcos = UnCliente "Marcos" 40 [rodri] [klusener "guinda"]

	cristian :: Cliente
	cristian = UnCliente "Cristian" 2 [] []

	ana :: Cliente
	ana = UnCliente "Ana" 120 [marcos,rodri] [grogXD, jarraLoca]


	--3

	cantidadAmigos :: Cliente -> Int
	cantidadAmigos = length.amigos

	comoEsta :: Cliente -> String
	comoEsta cliente | (>50).resistencia $ cliente = "Fresco" | (/=0).cantidadAmigos $ cliente = "Piola" |  otherwise = "Duro"



	-- 4

	obtenerNombresDeAmigos :: Cliente -> [String]
	obtenerNombresDeAmigos cliente = (map nombre).amigos $ cliente

	agregarAmigo :: Cliente -> Cliente -> Cliente
	agregarAmigo cliente nuevoAmigo | sePuedeAgregar cliente nuevoAmigo = cliente { amigos = nuevoAmigo : amigos cliente} | otherwise = cliente

	sePuedeAgregar :: Cliente -> Cliente -> Bool
	sePuedeAgregar cliente nuevoAmigo | (esElMismoNombre cliente nuevoAmigo) = False | (chequearSiSonAmigos cliente nuevoAmigo) = False | otherwise = True


	esElMismoNombre :: Cliente -> Cliente -> Bool
	esElMismoNombre cliente nuevoAmigo = nombre cliente == nombre nuevoAmigo 

	chequearSiSonAmigos :: Cliente -> Cliente -> Bool
	chequearSiSonAmigos cliente nuevoAmigo = elem (nombre nuevoAmigo) (obtenerNombresDeAmigos cliente)


	--5

	type Bebida = Cliente -> Cliente



	grogXD :: Bebida
	grogXD cliente = modificarResistencia (-(resistencia cliente)) cliente



	modificarResistencia :: Int -> Cliente -> Cliente

	modificarResistencia nivel cliente = cliente { resistencia = ((+nivel).resistencia) cliente }



	jarraLoca :: Bebida

	jarraLoca cliente = cliente { resistencia = (resistencia cliente) - 10, amigos = map ( modificarResistencia (-10) ) (amigos cliente) }



	klusener :: String -> Bebida

	klusener gusto = modificarResistencia (-(length gusto)) 

	tintico :: Bebida

	tintico cliente = modificarResistencia (((5*).cantidadAmigos) cliente ) cliente


	soda :: Int -> Bebida

	soda fuerza cliente = cliente { nombre = "e"++ (replicate fuerza 'r') ++ "p" ++ nombre cliente }



	--6

	rescatarse :: Int -> Cliente -> Cliente

	rescatarse horas cliente | horas > 3 = modificarResistencia 200 cliente | horas > 0 = modificarResistencia 100 cliente



	--7
	-- > ((klusener "huevo").(rescatarse 2).(klusener "Chocolate").jarraLoca) ana



	--Parte 2 



	--1

	tomarBebida :: Cliente -> Bebida -> Cliente

	tomarBebida cliente bebida = bebida (cliente {tragosQueTomo =  [bebida] ++ (tragosQueTomo cliente)}) 



	tomarTragos :: Cliente -> [Bebida] -> Cliente
	tomarTragos cliente bebidas = foldl1 (.) (map (flip tomarBebida) bebidas) cliente

	hacerCosas:: Cliente -> [Bebida] -> Cliente
	hacerCosas cliente bebidas  = foldl1 (.) bebidas cliente



	dameOtro :: Cliente -> Cliente
	dameOtro cliente | null.tragosQueTomo $ cliente = cliente |otherwise = tomarBebida cliente (head  (tragosQueTomo cliente))




	--2

	resisteLaBebida :: Cliente -> Bebida -> Bool
	resisteLaBebida cliente bebida = (>0).resistencia $ (bebida cliente) 

	cualesPuedeTomar :: Cliente -> [Bebida] -> [Bebida]
	cualesPuedeTomar cliente bebidas = filter (resisteLaBebida cliente) bebidas 


	cuantasPuedeTomar :: Cliente -> [Bebida] -> Int
	cuantasPuedeTomar cliente = length.(cualesPuedeTomar cliente)

	--3

	data Itinerario = UnItinerario {nombreItinerario :: String, duracion :: Float, programa :: ([Bebida],[Bebida]) } deriving (Show)

	mezclaExplosiva :: Itinerario
	mezclaExplosiva = UnItinerario "Mezcla Explosiva" 2.5 ([grogXD, grogXD, klusener "huevo", klusener "frutilla"],[])

	itinerarioBasico :: Itinerario
	itinerarioBasico = UnItinerario "Itinerario Basico" 5 ([klusener "huevo",klusener "Chocolate", jarraLoca],[rescatarse 2])

	salidaDeAmigos :: Itinerario
	salidaDeAmigos = UnItinerario "Salida De Amigos" 1 ([ (soda 1),tintico,jarraLoca], [ (flip agregarAmigo robertoCarlos)])

	robertoCarlos:: Cliente
	robertoCarlos = UnCliente "Roberto Carlos" 165 [] []


	itinerar :: Itinerario -> Cliente -> Cliente
	itinerar itinerario cliente = hacerCosas (tomarTragos cliente (fst (programa itinerario))) (snd (programa itinerario))

	--itinerar rodri salidaConAmigos, itinerar marcos mezclaExplosiva


	--4
	intensidad :: Itinerario -> Float
	intensidad itinerario =   (/ (duracion itinerario)) (genericLength ( (fst (programa itinerario))++(snd (programa itinerario) ) ) )


	comprobarSiEsElDeMayorIntensidad :: Float -> Itinerario -> Bool 
	comprobarSiEsElDeMayorIntensidad n itinerario = (==) n (intensidad itinerario)

	elMasIntenso:: [Itinerario] -> Itinerario
	elMasIntenso lista = head (filter (comprobarSiEsElDeMayorIntensidad (laIntensidadDelItinerarioDeMayorIntesidad lista) ) lista)


	laIntensidadDelItinerarioDeMayorIntesidad :: [Itinerario] -> Float
	laIntensidadDelItinerarioDeMayorIntesidad lista = (maximum (map intensidad lista))


	hacerElItinerarioMasIntenso :: Cliente -> Cliente

	hacerElItinerarioMasIntenso cliente = itinerar (elMasIntenso [mezclaExplosiva, itinerarioBasico, salidaDeAmigos]) cliente

	--5

	listaInfinitaDeSodas :: [Bebida]

	listaInfinitaDeSodas = map (\(x,y) -> x y)(zip (repeat soda) [1..])


	chuckNorris :: Cliente
	chuckNorris = UnCliente "Chuck" 1000 [ana] listaInfinitaDeSodas



	jarraPopular :: Int -> Cliente -> Cliente
	jarraPopular espirituosidad cliente = foldl agregarAmigo cliente (buscarAmigos espirituosidad (amigos cliente))


	buscarAmigos :: Int -> [Cliente] -> [Cliente]

	buscarAmigos 0 clientes = []
	buscarAmigos espirituosidad clientes = (amigosDe clientes) ++ (buscarAmigos (espirituosidad - 1) $ amigosDe clientes)


	--amigosDe :: Cliente -> [Cliente]
	amigosDe clientes = foldMap amigos clientes 

