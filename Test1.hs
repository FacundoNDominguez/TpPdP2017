import Test.Hspec
import Control.Exception
import TP2

main = hspec $ do
	describe "Punto 3" $ do
		it "Cristian debe estar duro" $do
			comoEsta cristian `shouldBe` "duro"
		it "Rodri debe estar fresco" $do
			comoEsta rodri `shouldBe` "fresco"
		it "Marcos debe estar duro" $do
			comoEsta marcos `shouldBe` "duro"
		it "Si Marcos se hace amigo de Ana y Rodri, esta piola" $do
			comoEsta (agregarAmigo(agregarAmigo marcos ana) rodri) `shouldBe` "Piola"

	describe "Punto 4" $do
		it "Rodri intenta hacerse amigo de si mismo" $do
			length (amigos (agregarAmigo rodri rodri)) `shouldBe` 0
		it "Marcos intenta hacerse amigo de Rodri, de quien ya es amigo" $do
			length (amigos (agregarAmigo marcos rodri)) `shouldBe` 1
		it "Rodri intenta hacerse amigo de Marcos, que no era su amigo" $do
			length (amigos (agregarAmigo rodri marcos)) `shouldBe` 1

	describe "Punto 5" $do
		it  "Ana toma GrogXD. Queda con resistencia 0." $do
			resistencia (grogXD ana) `shouldBe` 0
		it  "Ana toma la Jarra Loca. Queda con resistencia 110, su amigo Marcos queda con 30 de resistencia y su amigo Rodri queda con 45 de resistencia" $do
			(resistencia.jarraLoca) ana `shouldBe` 110
			(resistencia.head.amigos.jarraLoca) ana `shouldBe` 30
			(resistencia.last.amigos.jarraLoca) ana `shouldBe` 45
		it  "Ana toma un Klusener de huevo, queda con 115 de resistencia" $do
			( resistencia.(klusener "huevo") ) ana `shouldBe` 115
		it  "Ana toma un Klusener de chocolate, queda con 111 de resistencia" $do
			resistencia (klusener "chocolate" ana) `shouldBe` 111
		it  "Cristian toma un Tintico, queda con 2 de resistencia por no tener amigos" $do
			resistencia (tintico cristian) `shouldBe` 2
		it  "Rodri toma una Soda de fuerza 2, queda con nombre errpRodri " $do
			nombre (soda 2 rodri) `shouldBe` "errpRodrigo"
		it  "Ana toma una Soda de fuerza 10, queda con nombre errrrrrrrrrpAna" $do
			nombre ( soda 10 ana) `shouldBe` "errrrrrrrrrpAna"
		it  "Ana toma una Soda de fuerza 0, queda con nombre epAna" $do
			nombre ( soda 10 ana) `shouldBe` "epAna"
	describe "Punto 6" $do
		it  "Rodri se rescata 5 horas, queda con 255 de resistencia" $do
			resistencia (rescatarse 5 rodri) `shouldBe` 255
		it  "Rodri se rescata 1 horas, queda con 155 de resistencia" $do
			resistencia (rescatarse 1 rodri) `shouldBe` 155
	describe "Punto 7" $do
		it  "Luego de evaluar el itinerario de Ana, queda con 196 de resistencia, como amigos a Marcos (30 de resistencia) y Rodri (45 de resistencia)." $do
			(resistencia.(klusener "huevo").(rescatarse 2).(klusener "Chocolate").jarraLoca) ana `shouldBe` 196
			(resistencia.head.amigos.jarraLoca) ana `shouldBe` 30
			(resistencia.last.amigos.jarraLoca) ana `shouldBe` 45