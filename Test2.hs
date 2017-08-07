import Test.Hspec
import Control.Exception
import TP2

main = hspec $ do
	describe "Punto 1b" $ do
		it "Marcos toma una soda de nivel 3 y queda con 2 bebidas" $do
			length ( tragosQueTomo (tomarBebida marcos (soda 3))) `shouldBe` 2
		it "Marcos toma una soda de nivel 3 y queda con 40 de resistencia" $do
			resistencia (tomarBebida marcos (soda 3)) `shouldBe` 40
	describe "Punto 1c" $ do
		it "Rodri toma una soda de nivel 1 y una soda de nivel 2 y queda con nombre errperpRodri" $do
			nombre ( ( (soda 2).(soda 1) ) rodri) `shouldBe` "errperpRodri"
		it "Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 30 de resistencia" $do
			resistencia ( ( (klusener "huevo").tintico.jarraLoca ) $ marcos ) `shouldBe` 30
		it "Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 4 bebidas en el historial" $do
			length ( tragosQueTomo ( tomarBebida (tomarBebida (tomarBebida marcos (klusener "huevo")) tintico ) jarraLoca) ) `shouldBe` 4
	describe "Punto 1d" $ do
		it "Marcos pide “dame otro” y tiene 2 bebidas en el historial" $do
			length ( tragosQueTomo ( dameOtro marcos )) `shouldBe` 2
		it " Marcos pide “dame otro” y lo deja con 34 de resistencia " $do
			resistencia (dameOtro marcos) `shouldBe` 34
		it "Rodri toma una soda de nivel 1, y dameOtro da como resultado que tiene 3 bebidas" $do
			length ( tragosQueTomo ( dameOtro (tomarBebida rodri (soda 1)))) `shouldBe` 3
		it "Rodri toma una soda de nivel 1, y dameOtro da como resultado que su nombre queda “erperpRodri”" $do
			nombre (dameOtro (tomarBebida rodri (soda 1))) `shouldBe` "erperpRodrigo"
	describe "Punto 2b" $ do
		it "Rodri puede tomar dos bebidas, entre un grog XD, un tintico y un klusener de frutilla" $do
			cuantasPuedeTomar rodri [grogXD, tintico, klusener "frutilla"] `shouldBe` 2
		it "Rodri puede tomar dos bebidas, entre un grog XD, un tintico, un klusener de fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla se puede tomar una sola bebida" $do
			cuantasPuedeTomar rodri [grogXD, tintico, klusener "fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla"] `shouldBe` 1
	describe "Punto 3b" $ do
		it "Rodri hace una salida de amigos y debe quedar con un amigo" $do
			cantidadAmigos (itinerar salidaDeAmigos rodri)  `shouldBe` 1
		it "Rodri hace una salida de amigos y se debe llamar “erpRodri”" $do
			nombre (itinerar salidaDeAmigos rodri) `shouldBe` "erpRodrigo"
		it "Rodri hace una salida de amigos y debe quedar con 45 de resistencia " $do
			resistencia (itinerar salidaDeAmigos rodri) `shouldBe` 45
		it "Rodri hace una salida de amigos y su primer y su único amigo Roberto Carlos debe quedar con 155 de resistencia ( es incompatible con un resultaddo correcto del test anterior)" $do
			( (resistencia.head.amigos) ) (itinerar salidaDeAmigos rodri) `shouldBe` 155
		it "Rodri hace una salida de amigos y debe quedar con 4 bebidas en su historial" $do
			 ( (length.tragosQueTomo)) (itinerar salidaDeAmigos rodri) `shouldBe` 4
	describe "Punto 4a" $ do
		it "la intensidad de la mezcla explosiva es 1.6" $do
			intensidad mezclaExplosiva `shouldBe` 1.6
		it "la intensidad de la salidaDeAmigos es 4.0" $do
			intensidad salidaDeAmigos `shouldBe` 4.0
		it "la intensidad del itinerario basico es 0.8" $do
			intensidad itinerarioBasico `shouldBe` 0.8
	describe "Punto 4b" $ do
		it "Entre la salida de amigos, la mezcla explosiva y el itinerario básico, el itinerario más intenso es la salida de amigos" $do
			nombreItinerario (elMasIntenso [salidaDeAmigos, itinerarioBasico,mezclaExplosiva]) `shouldBe` "Salida De Amigos"
		it "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con el nombre erpRodri " $do
			nombre (itinerar (elMasIntenso [salidaDeAmigos, itinerarioBasico,mezclaExplosiva]) rodri) `shouldBe` "erpRodrigo"
		it "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con resistencia 45" $do
			resistencia (itinerar (elMasIntenso [salidaDeAmigos, itinerarioBasico,mezclaExplosiva]) rodri) `shouldBe` 45
		it "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con un amigo: Roberto Carlos" $do
			cantidadAmigos (itinerar (elMasIntenso [salidaDeAmigos, itinerarioBasico,mezclaExplosiva]) rodri) `shouldBe` 1
	describe "Punto 6" $ do
		it "Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 0, sigue quedando con una sola amiga (Ana)" $do
			cantidadAmigos (jarraPopular 0 (agregarAmigo robertoCarlos ana)) `shouldBe` 1
		it "Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 3, queda con 3 amigos (Ana, Marcos y Rodri)" $do
			length (amigos (jarraPopular 3 (agregarAmigo robertoCarlos ana))) `shouldBe` 3
		it "Cristian se hace amigo de Ana. Roberto Carlos se hace amigo de Cristian, toma una jarra popular de espirituosidad 4, queda con 4 amigos (Cristian, Ana, Marcos y Rodri)" $do
			( length.amigos ) (jarraPopular 4 (agregarAmigo robertoCarlos (agregarAmigo cristian ana))) `shouldBe` 4
