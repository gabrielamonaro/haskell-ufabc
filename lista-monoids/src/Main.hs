module Main (main) where

import Data.List 

{- Questao 1
Considere o tipo Resultado que representa o resultado das atividades entregues por um aluno. No final do quad, deseja somar a pontuação de todas as atividades. No caso de cola, toda a pontuacao obtida até o momento deve ser descartada - reprovacao automatica. Implemente uma instancia de monoide para Resultado que modele esse comportamento.

*** Semigroup   é uma par:
(C, <>) 
(Um conjunto de valores, e uma operação)

a <> b = r, onde r pertence a C - Ou seja, <> é fechada em C
a <> b <> c = (a <> b) <> c = a <> (b <> c) - ou seja, <> é associativa

Exemplos de semigrupos:
(N, +)
(N, *)

*** Monoide 
(C, <>, e)
Onde e é o elemento neutro da operacao a direita e a esquerda
a <> e = a
e <> a = a

Exemplos de monoides: 
(N, +, 0)
(N, *, 1)


-}
data Resultado 
  = Pontuacao Int | Cola deriving (Show, Eq)

-- o semigroup precisa ser definido antes que o monoide:
 
-- O conjunto que estamos trabalhando é Resultado (do data Resultado). Nosso semigroup será (Resultado, <>) 
instance Semigroup Resultado where
  Cola <> _ = Cola
  _ <> Cola = Cola
  (Pontuacao x) <> (Pontuacao y) = Pontuacao (x + y)    -- o resultado precisa estar contido no conjunto Resultado, por isso usamos Pontuacao antes da soma
-- definimos a operacao associativa

-- Agora definimos o monoide - o que falta é o elemento neutro - definimos como mempty

instance Monoid Resultado where
    mempty = Pontucao 0


-- primeiro definimos o semigroup e depois o monoide -- ambos devem possuir o mesmo nome


{-
Questao 2: Condidere o tipo Set que deve representar um conjunto arvitrario de qualquer a. 
A lista armazenada pelo cosntrutor Set deve sempre conter elementos únicos e ordenados.

Implemente uma instancia de Show para o set, que mostre-o conforme o seguinte exemplo:
Set [1,2,4] => {1,2,4} (considere a função intercalate do Data.List).
Implemente uma função `fromList :: Ord a => [a] -> Set a` que gera um conjunto a partir de uma lista;
Implemente uma função `member :: Ord a => a -> Set a -> Bool` que retorna se um elemento pertence aquele conjunto.
Implemente uma função `insert :: Ord a => a -> Set a -> Set a` que adiciona o elemento passado como parametro no conjunto passado como parametro.
Implemente uma função `delete :: Ord a => a -> Set a -> Set a` que faz o inverso da anterior.

temos um conjunto que guarda qualquer coisa - não temos elementos únicos 
-}

data Set a =
    Set [a]
    deriving (Eq)

{- 2.1 Implemente uma instancia de Show para o set, que mostre-o conforme o seguinte exemplo: Set [1,2,4] => {1,2,4} (considere a função intercalate do Data.List).

intercalate :: [a] -> [[a]] -> [a]
intercalate :: String -> [String] -> String

ghci> intercalate "x" ["a","b","c"]
"axbxc"

Vamos usar o intercalte para colocar as vírgulas
-}

instance Show a => Show (Set a) where           -- a precisa ser exibivel
    show (Set xs) = "{" <> intercalate "," (map show xs) <> "}"         -- estamos usando o monoide de listas nativo do haskell


{- 2.2 Implemente uma função `fromList :: Ord a => [a] -> Set a` que gera um conjunto a partir de uma lista

- devem ser únicos e ordenados.

-}

fromList :: Ord a => [a] -> Set a
fromList xs = Set & sort (nub xs)       -- tira os elementos duplicados com nub e ordena com o sort
{- 2.3 Outra forma de escrever a funcao acima:
fromList = Set . sort . nub
-}

--2.4 Implemente uma função `member :: Ord a => a -> Set a -> Bool` que retorna se um elemento pertence aquele conjunto.
member :: Ord a => a -> Set a -> Bool
member e (Set xs) = e `elem` xs

--2.5 Implemente uma função `insert :: Ord a => a -> Set a -> Set a` que adiciona o elemento passado como parametro no conjunto passado como parametro.
insert :: Ord a => a -> Set a -> Set a
insert e (Set xs) = fromList(e : xs)

--2.6 Implemente uma função `delete :: Ord a => a -> Set a -> Set a` que faz o inverso da anterior.
delete :: Ord a => a -> Set a -> Set a
delete e (Set xs) = Set(delete e xs)        --delete já vem na biblioteca padrão de haskell

-- Questão 3: Implemente uma instância de Monoid para Set a, dado que a seja Ord utilizadndo a operação de união de conjuntos.

-- primeiro criamos um semigroup

instance Ord a => Semigroup (Set a) where
    (Set xs) <> (Set ys) = fromList(xs <> ys)         -- monoid de listas padrão

-- Nosso semigroup tem como conjunto (Set a) e como operador o mesmo que o padrão do haskell para listas.

instance Ord a => Monoid (Set a) where
    mempty = Set []

-- Questão 4: Lanchonete sem cardapio fixo. Voce apenas fornece uma lista de ingredientes possiveis e os clientes podem combina-los como bem entenderem. Considere os tipos data Dieta e data Lanche. Dessa forma, um lanche é composto por um conjunto de ingredientes, um preco em centavos e qual o tipo de dieta adequado para aquele lanche. Implemente uma instancia de monoide para Dieta considerando o seguinte que duas dietas são combinadas usando 'denominador comum', ou seja, duas dietas diferentes resultam em menos restritiva>
    -- -Se vc colocar queijo em um lanche vegano, ele deixa de ser vegano;
    -- -Mas colocar queijo em um lanche tradicional não faz com que ele deixe se ser tradiiconal

data Dieta
    = Vegano 
    | Vegetariano
    | Tradicional
    deriving (Show, Eq)

-- primeiro a instancia de semigroups

instance Semigroup Dieta where
    Vegano <> Vegano = Vegano
    Tradicional <> _ = Tradicional
    _ <> Tradicional = Tradicional      -- como é associativo, precisamos necessariamente definir os dois lados
    _ <> _ = Vegetariano                -- essa linha abraça os casos das proximas duas linhas abaixo pq se chegou até aqui, só pode ser a combinação de vegetariano com vegano ou vegetariano com vegetariano - que sempre resulta em vegetariano
    -- Vegetariano <> _ = Vegetariano
    -- Vegano <> Vegetariano = Vegano

-- instanciando o monoide

instance Monoid Dieta where 
    mempty = Vegano     

{- Questão 5: Implemente uma instancia de monoide para o Lacnhe conforme as seguintes regras para combinar dois lanches:
     - a lista de ingredientes deve ser combinada usando a união de conjuntos (pode usar sua implementação de `<>`);
     - o preço deve ser simplementes somado;
     - A Dieta deve seguir o `<>` implementado anteriormente. -}

data Lanche =
    Lanche (Set String) Int Dieta 
    deriving (Show, Eq)

instance Semigroup Lanche where
    (Lanche s0 v0 d0) <> (Lanche s1 v1 d1) = Lanche (s0 <> s1) (v0 + v1) (d0 <> d1)

instance Monoid Lanche where
    mempty = Lanche mempty 0 mempty         -- essa combinação é: Lanche mempty(elemento neutro do Set a) 0 (elemento neutro da soma) e mempty(elemento neutro da Dieta)


data Lanche =
    Lanche (Set String) Int Dieta
    deriving (Show, Eq)

main :: IO ()
main = do
  let n = nome 1
  print n
