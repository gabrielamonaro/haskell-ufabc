module Main (main) where

import Data.List 

data Set a =
    Set [a]
    deriving (Eq)

instance Show a => Show (Set a) where           
    show (Set xs) = "{" <> intercalate "," (map show xs) <> "}"         


fromList :: Ord a => [a] -> Set a
fromList xs = Set & sort (nub xs)       

member :: Ord a => a -> Set a -> Bool
member e (Set xs) = e `elem` xs

insert :: Ord a => a -> Set a -> Set a
insert e (Set xs) = fromList(e : xs)

delete :: Ord a => a -> Set a -> Set a
delete e (Set xs) = Set(delete e xs)        


instance Ord a => Semigroup (Set a) where
    (Set xs) <> (Set ys) = fromList(xs <> ys)         

instance Ord a => Monoid (Set a) where
    mempty = Set []


{-
Questão 1: Implemente a função `mapSet :: (Ord a, Ord b) => (a -> b) -> Set a -> Set b` para o Set a.
-}

mapSet :: (Ord a, Ord b) => (a -> b) -> Set a -> Set b
mapSet f (Set xs) = fromList(map f xs)                  -- usamos fromList para garantir que a lista será de elementos únicos e ordenados

-- usamos a função fromList para criar Sets - assim protegendo que sempre permaneça com os requisitos

{-
Questão 2: Implemente uma instância de Foldable para o Set a


A classe Foldable em Haskell é usada para estruturas de dados que podem ser "dobradas" ou "reduzidas" (folded) em um único valor. Essencialmente, ela generaliza o conceito de reduzir uma lista (como com as funções foldr ou foldl) para outras estruturas de dados, como árvores, mapas, ou qualquer outro tipo de contêiner.
A classe foldable precisa que no mínimo sejam implementados foldMap OU foldr

foldMap: Mapeia cada elemento da estrutura para um monoide e depois combina todos esses valores.
foldMap :: Monoid m => t m -> m

-}

instance Foldable Set where
 -- foldMap :: Monoid m => (a -> m) -> t a -> m
    foldMap f (Set xs) = foldMap f xs

 -- foldr :: (a -> b -> b) -> b -> t a -> b
    foldr f acc (Set xs) = foldr f acc xs

-- aproveitamos as funções que já foram definidas pela própria classe foldable


{-
Questão 3: Considere a estrutura data Replist a feita para armazenar de forma eficiente listar com muitos elementos repetidos. Cada posição da lista armazena, além de um elemento, quantas vezes ele deve ser repetido.
Implemente a função `listToRepList :: [a] -> RepList a` que faz justamente as conversões conforme a seguir:

- RepNil representa o final de uma lista

listToRepList [1, 1, 2, 2, 2] == Repat 2 1 (Repeat 3 2 RepNil)
listToRepList [1, 2, 3, 3, 3, 2, 2] == Repat 1 1 (Repeat 1 2 (Repeat 3 3 (Repeat 2 2 RepNil)))
listToRepList ['a', 'x', 'x', 'z', 'x'] == Repat 1 'a' (Repeat 2 'x' (Repeat 1 'z' (Repeat 1 'x' RepNil)))
-}

-- RepList é uma lista ligada (encadeada) onde o valor de cada elemento é o valor da repetição seguido do item a ser repetido, seguido do valor do próximo elemento: Int a (RepList a)
data RepList a 
    = Repeat Int a (RepList a) 
    | RepNil
    deriving (Show, Eq)

-- group é uma função do Data.List
-- > group "aaaabbcccaa"
-- > ["aaaa", "bb", "ccc", "aa"]

listToRepList :: Eq a => [a] -> RepList a 
listToRepList xs = foldr ((\v acc -> Repeat (length v) (head v) acc) RepNil group xs)

{-
(\v acc -> Repeat (length v) (head v) acc) 
a função utilizada acima é uma função anônima (não recebe nome) que é usada de forma a atender o primeiro argumento da função foldr

foldr :: (a -> b -> b) -> b -> [a] -> b
(a -> b -> b) é implementado por (\v acc -> Repeat (length v) (head v) acc) 
onde:
    * v é o valor do tipo a (cada elemento que vem da lista);
    * acc é o valor do tipo b (acumulador) - (que nesse caso receberá um algo do tipo RepList)
    
-} 

-- QUestão 4: Implemente uma instância de foldable para RepList

instance Foldable RepList where
     -- foldMap :: Monoid m => (a -> m) -> t a -> m
    folMap _ RepNil = mempty
    foldMap f (Repeat n v prox) =
        foldMap f (replicate n v) <> foldMap f prox

-- a função foldMap precisa receber uma função; o contêiner que estamos trabalhando (nesse caso o RepList que é t)
-- no caso, temos 2 constrututores do nosso tipo: RepNill e RepList


{-
Functors - functors são tipos que podem ser mapeados sobre. Formalmente, um functor é uma estrutura de dados que implementa a classe de tipo Functor, que define como aplicar uma função a cada elemento de uma estrutura sem alterar a estrutura em si.
    mínimo para implementar: 
    fmap :: (a -> b) -> f a -> f b

    f é o tipo que implementa Functor. nosso tipo 'personalizado'

    fmap é a função fundamental do Functor. Ela pega uma função que transforma um tipo a em um tipo b (a -> b) e a aplica a cada elemento dentro da estrutura f, transformando assim um f a em um f b.
-}

{- Questão bônus: É posível implementar uma instancia de Funcotr para o Set a da ultima lista, respeitando as leis dos Functos e dos Sets?

A definição de fmap deve obedecer duas propriedades:

fmap id = id
fmap f . fmap g = fmap (f.g)

fmap f (fmap g) = fmap (\x -> f (g x))
\x -> fmap f (fmap g x) = fmap (\y -> f (g y))

-}

-- instance Functor Set where
    -- fmap f (Set xs) = mapSet f (Set xs)      -- isso não está correto porque o mapSet usa uma restrição de que a e b precisam ser Ord a e Ord b


{-
COnidere o tipo para implementar uma hierarquia de memoria para um emulador MINIPS.
Essa estrututra tem a propriedade de que sempre vai termoinar na memória RAM, e podemos ter quantos niveis de cache quisermos.

Por exemplo, se quisermos calcular o total de acessos feitos a todos os níveis de memória usando `SplitCache 5 2 (UnifiedCache 10 (RAM 5)`.
Imagine que queremos calcular o total de acessos feitos a todos os níveis de memória, podemos fazer: `SplitCache 5 2 (UnifiedCache 10 (RAM 5))`
Implemente instâncias de Functor, Foldable e Transversable para a estrutura Memory.


-}

data Memory a 
    = UnifiedCache a (Memory a)
    | SplitCache a a (Memory a)
    | RAM a
    deriving (Show, Eq)

-- ideia do functor: você tem um valor dentro de um contexto (como a em Set a) e você tem uma função - você precisa colocar a função aplicada dentro do contexto - é a mesma coisa que tirar o valor do contexto, aplicar a função e colocar o valor modificado de volta ao contexto

instance Functor Memory where
 -- fmap f m =      -- sempre recebo uma função e o tipo e preciso devolver a funcao aplicada
    fmap f (RAM a) = RAM $ f a      -- aplico a função ao valor que está dentro da caixa
    fmap f (UnifiedCache a pmem) = UnifiedCache (f a) (fmap f pmem)     -- chamada recursiva, pq precisa terminar em RAM a
    fmap f (SplitCache a b pmem)
        = SplitCache (f a) (f b) (fmap f pmem)
    
-- Aplico a função ao valor que está dentro do contexto e envelopo de volta ao contexto


-- Foldable
    instance Foldable Memory where
     -- foldMap :: Monoid m => (a -> m) -> t a -> m
        foldMap f (RAM a) = f a
        foldMap f (UnifiedCache a pmem) = f a <> foldMap f pmem         -- usamos o append para juntar monoides - o resultado de saída precisa ser somente um monóide
        -- usamos também a recursividade, sempre que tivermos tipos recursivos
        foldMap f (SplitCache a b pmem) = f a <> f b <> foldMap f pmem


{-
    Transversable: Traversable é uma classe de tipos em Haskell que representa estruturas de dados que podem ser percorridas, ou seja, você pode "atravessá-las" aplicando uma função que envolve efeitos (como Maybe, IO, listas, etc.) a cada elemento da estrutura e depois recolher esses efeitos de forma estruturada.


    class (Functor t, Foldable t) => Traversable t where
        traverse :: Applicative f => (a -> b) -> t a -> f (t b)
        sequenceA :: Applicative f => t (f a) -> f (t a)

        {#MINIMAL traverse|sequenceA}

    -- para ser um traversable, precisa ser primeiro um Functor e Foldable.

Applicative:
    class Functor f => Applicative f where
        pure :: a -> f a                -- pega um valor puro a e coloca dentro do tipo f 
        (<*>) :: f (a -> b) -> f a -> f b
        {#MINIMAL pure, (<*>)}              --pega uma funcao que está dentro do contexto (tipo f) e pega também um valor a aplicado no mesmo contexto e devolve um valor b dentro desse mesmo contexto

    -- para ser um Applicative, precisa primeiro f ser um Functor

-}

instance Transversable Memory where
        -- traverse :: Applicative f => (a -> b) -> Memory a -> f (Memory b)
        traverse fn (RAM a) = fmap RAM(fn a)
        

main :: IO ()
main = do
  let n = nome 1
  print n
