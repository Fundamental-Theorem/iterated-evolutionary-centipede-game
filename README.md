# Evolutionary Iterated Centipede Game

This project on Game Theory revolves around games derived from the classic Centipede game, an extensive form game of
perfect information played by two players, and explored various experimental approached and variants of it. This work is inspired under the paper

[]

The standard Centipede game is first converted into an equivalent normal‑form representation. To eliminate the inherent asymmetry between the first and second mover, the identity of the initial player is randomized, resulting in the one‑round symmetric centipede (OSC), which has been examined previously across theoretical, evolutionary, and computational studies. The primary focus of the project is the analysis of the ISC, defined as repeated play of the OSC for $T$ rounds. In this setting, all previous rounds are remembered by both players, enabling the use of memory‑based strategies. This structure naturally allows strategies to be adapted so that cooperation can be encouraged and defection penalized across rounds. The ISC is framed as an evolutionary tournament in the style of classic IPD research, and it examined through the lens of replicator dynamics in a large population game, as well as a markovian analysis of a small population game.

#### Contents

1. Classic Centipede Game
2. One Round Symmetric Centipede Game (OSC)
3. Iterated Centipede Game (ISC)
4. Replicator Dynamics
5. Markovian Analysis

---

## 1. Classic Centipede Game

The game of centipede has been introduced in [13]. In subsequent works, many variants of the
original game have been introduced, but they all share some basic characteristics.
1. It is an extensive form game of perect information (a tree game).
2. The game tree has the “centipede shape”, namely it consists of a path of M vertices, with
each path vertex also having an additional edge ending at a leaf vertex. Hence, the game
tree contains a total of 2M vertices; we denote the path vertices as 1, 2, ..., M and the
leaves as M + 1,M + 2, ..., 2M.
3. The terminal vertices are M + 1, M + 2, ..., 2M; the (M + m)-th vertex has payoffs
(am, bm).
4. The payoffs satisfy:
a1 > a2, a3 > a4, a5 > a6, ...
b1, b2 > b3, b4 > b5, b6 > b7, ...

The game is played as follows:
1. P1 plays at odd turns, P2 plays at even turns.
2
2. The sum of payoffs at the t-th turn is ct = at+bt = f (t), where f is an increasing function
of t.
3. The ct is divided as follows: if the moving player goes to the leaf vertex, he receives pct
(with p ∈ ( 1
2 , 1] and the other player receives (1 − p) ct.

---

# 2. 


