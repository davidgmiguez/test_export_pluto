### A Pluto.jl notebook ###
# v0.19.38

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 45ad05da-4f14-426b-a497-52c63b0f0b2e
using Images, Plots,PlutoUI, DataFrames, Statistics

# ╔═╡ 5dba5e73-390a-49ca-8c75-541d3299a741
#TableOfContents(title="📚 Systems in steady state", indent=true, depth=1, aside=true)

# ╔═╡ 137f51d2-c6e1-4d39-a8c7-3c1f850ae1d2
html"<button onclick='present()'>present</button>"

# ╔═╡ e474a63a-91e4-4ec0-b301-e3b1b261fc28
md" # 2 Systems in steady state

There are many ways of working with systems of multiple interacting entities. We can start from a simple analysis of the organization of the system in a steady state. To illustrate these type of analysis, we will use ecosystems as our main system example. Ecosystems are compose of parts (animals, plants...) that interact (they mate and produce progeny, the eat each other...), and it is straightforward  to think about values such as diversity, extintion and other common concepts used in systems analysis. "

# ╔═╡ 0ebe3384-97aa-11ec-17b5-cbf23568df03
md" 

# 2.1 Quantification of system composition 

*Diversity* is simply a measure of how many types of _parts_ are forming a given system. Diversity in a system is a very important property because it is directly  related to robustness and adaptation, because when some parts of the system perform different tasks, the system itself may respond better to sudden environmental changes, as occurs in ecosystems. 

##
- How do we measure this diversity? 
- is it a system composed of parts that are almost identical a diverse system? 
- Is a bag of apples diverse? 

Actually, the definition of diversity depends of what are we focusing on. Therefore the measure of diversity is going to depend on the  of system we are dealing with. 

##
For instance, let's say we want to measure diversity in size in a population of bacteria. In these type on non-divense systems, we can just use the value of the standard deviation, so a large std means that the system is very diverse, and a small std suggest smaller diversity. 

##
But now let's try to characterize the *diversity* of a diverse system, i.e., a system composed on several species. Now, we cannot define a single value of standard deviation, so another ways to characterize this feature are required.
"

# ╔═╡ 35524d0e-64ce-4020-a6db-e3b6ea71a777
Resource("https://i.ibb.co/L0CMqQg/ecosystems.jpg",:width => 600 )

# ╔═╡ 8ad237fa-8a09-4bae-80f4-ba1298c09581
begin
	dog_slide = @bind 🐶 html"<input type=range min=0 max=100 step=1>"
	mouse_slide = @bind 🐭 html"<input type=range min=0 max=100 step=1>"
	cat_slide = @bind 😺 html"<input type=range min=0 max=100 step=1>"
	fox_slide = @bind 🦊 html"<input type=range min=0 max=100 step=1>"
	bear_slide = @bind 🐻 html"<input type=range min=0 max=100 step=1>"
	
	md"""
	##
	Suppose a biologist wants to measure the diversity of species in a local forest. She collects the following data (change the sliders to change the amounts of individuals of each species):
	
	🐶 $(dog_slide)
	🐭 $(mouse_slide)
	😺 $(cat_slide)
	
	🦊 $(fox_slide)
	🐻 $(bear_slide)
	"""
end

# ╔═╡ bee1dd58-c8e6-4fa6-8eae-7cd4cca0a466
values_animals=DataFrame("Species" => ["🐶", "🐭", "😺",  "🦊",  "🐻"],"Frequency" => [🐶, 🐭, 😺, 🦊, 🐻])

# ╔═╡ ee9bef40-165f-4e26-8ee3-f2b96945bbc9
md" ##
A first characterization of the ecosystem is to calculate the total number of organisms"

# ╔═╡ 279b1402-f4ba-4a3b-9d7d-82ac81b515e4
 total_number_of_organisms=sum(values_animals.Frequency)

# ╔═╡ 4190734c-4c6e-4662-9be9-2c19c4956a38
md" ## 
Another very simple characterization is to measure how many different species does the ecosystem has. This what we called, the richness of a system $R$"

# ╔═╡ 9981448a-edee-435f-9d2b-ec3271c4016a
R=size(values_animals.Frequency,1);

# ╔═╡ c5216253-b818-4ea9-bba7-af8eeb6fd619
md" ##
For ecosystems, or systems composed of a number of individuals for each species, we often want to monitor if a given species dominates over the others, this is computed by the Dominance Index:

```math
D=\frac{\sum n_i(n_i-1)}{N(N-1)}
```

where $n_i$ is the number of organisms in a species i, and N is the total number of organisms. The Dominace index for the ecosystem defined above is

"

# ╔═╡ ffb98383-a88f-4a42-bf3f-e5709f98b143
md"##
Another highly used index is the Simpson’s Index of Diversity, which is simply 

```math
S=1-D=1-\frac{\sum n_i(n_i-1)}{N(N-1)}
```
and goes from $0$ (if one species fully dominates) to a maximum value where all species are equally represented. In particular, the Simpson’s index measures the probability that any two individuals drawn at random from an infinitely large community will belong to same species.

Play with sliders above to set a Diversity index of 0.85.


"

# ╔═╡ 3989ead3-2760-443f-80e8-21ac961e2ff5
D = (sum((values_animals.Frequency).* ((values_animals.Frequency) .- 1)) / (total_number_of_organisms*(total_number_of_organisms-1)));

# ╔═╡ 67091769-33dc-4b16-97b5-b817bf3699ec
md"you probably can't, because the probability depends on the number of species. 
Also, S=0 represents infinite diversity and S=1 represents no diversity. Thsi is why another very related measure is often used, the species __evenness__, that  refers to how close in numbers each species in an environment is. Mathematically it is defined as a diversity index, a measure of biodiversity which quantifies how equal the community is numerically. So if there are 40 foxes and 1000 dogs, the community is not very even.

##
Simpson evenness is closely related to Simpson diversity. It is actually just the Inverse Simpson Diversity with the richness added to the denominator, to mitigate the effect of species count on the range of the metric.
```math
E = \frac{1}{D * R}
```
it goes from a minimum value (if one species fully dominates) up to 1 (all species are equally represented). 

"

# ╔═╡ 8f31e31d-1080-4b22-b508-b71bf30c2ec0
E= 1/ D / R;

# ╔═╡ e6de7170-8b6f-4cf7-bd44-a8550486927d
S = 1 - D;

# ╔═╡ 5be26bca-bb7d-42d1-9fc8-d589d21ee9ff
md"
##
> __Task 1__: Measure the Richness, the dominance, the diversity and evenness of the following ecosystems. Which one is more a) diverse? b) even? c)  rich?
"


# ╔═╡ 721ad120-8999-4f9f-9bd3-b9d966246436
values_animals_2=DataFrame("Species" => ["🐭", "😺", "🦊",  "🐰",  "🐼", "🐮", "🐷", "🐸", "🐔", "🦆"],"System 1" => [10,9, 11, 10, 8, 12, 10,11,10,9], "System 2" => [72,9, 11, 10, 8, 12, 10,11,10,9],"System 3" => [33,33, 34, 0, 0, 0, 0, 0,0,0])

# ╔═╡ b20cdd19-08c4-4837-947f-97594b8822d2
md" # 2.2 Quantification of system interactions

As we mentioned, the important feature of the system comes from the interactions between the parts. Now we will see some tools to study how the parts of a system are interacting and connected.

- Proteins can act as transcription factors for other genes, forming complex networks that ultimately set the identity of a cell.

- When some node of the network changes (for instance, due to mutations), the behavior of a cell can change (leading to genetic diseases, such as cancer).

- Therefore, to understand and treat genetic diseases, we need  to know the genes involved, how they interact with other genes, and how they ultimately affect cellular responses.


"

# ╔═╡ 73f4fd5b-4611-4d90-8f05-af7b279dd86a
md" ##
### - 2.2.1 Network structure 
The structure of a network determines many relevant aspects of its function.
Network architecture is established by topological and statistical analyses.
Networks can be studied based on its global properties, (size, connectivity, robustness…) 

Depending of the nature of the links between nodes, we can classify networks in:

- Undirected: links between nodes have no direction (Facebook)
- Directed: links between nodes have direction (Twitter)
- Directed with self-links: Feedback loops (Gene regulatory networks)

"

# ╔═╡ 2180acb2-a298-4c87-8851-2fc5e322b51e
Resource("https://i.ibb.co/3ppK48s/tipos-networks.png")

# ╔═╡ 40f52fcb-4be1-40c1-8720-ee48433473f3
md" ##
### - 2.2.2. Network Size
The size of a network can refer to the number of nodes N or the number of links E.
The number of links is minimal in a tree network
"

# ╔═╡ ca9e7ee2-4a28-49da-994a-b721929882ec
Resource("https://i.ibb.co/rZkzZc7/tree.jpg")

# ╔═╡ af0276a5-322a-4a7f-9457-7e58524c5cbd
md" ##
The minimal number of links E in a network of N nodes $E_{min}$ = N-$1$
The maximum number of links depends of the type of network
For undirected

```math
E_{max}=\binom{N}{2}=\frac{N!}{2!(N-2)!)}=\frac{N(N-1)(N-2)...1}{2\cdot 1 \cdot (N-2)(N-3)...1}=\frac{N(N-1)}{2}
```

For directed 

```math
\begin{align*}
E_{max}=2\binom{N}{2}=N+\frac{2 \cdot N!}{2!(N-2)!)}=\\
\\
E_{max}=\frac{2 \cdot N(N-1)(N-2)...1}{2\cdot 1 \cdot (N-2)(N-3)...1}=N(N-1)
\end{align*}
```

##

For directed with self-links

```math
\begin{align*}
E_{max}=N+2\binom{N}{2}=N+\frac{2 \cdot N!}{2!(N-2)!)}=\\
\\
E_{max}=N+\frac{2 \cdot N(N-1)(N-2)...1}{2\cdot 1 \cdot (N-2)(N-3)...1}=\\
\\
E_{max}=N+N(N-1)=N(1+N-1)=N^2
\end{align*}
```



"

# ╔═╡ d4c87e16-8dff-4818-9bfc-df89c372a498
md" ##
### 2.2.3 Network Density

The density D of a network of N nodes is defined as a ratio of the number of links E to the number of possible links $E_{max}$

```math
\begin{align*}
D=\frac{E-(N-1)}{E_{max}-(N-1)}
\end{align*}
```


"

# ╔═╡ 477ba0d8-1dd9-46c8-bff0-72e4bfa89238
md"
> __Task 2__: Draw two networks of 5 nodes at random, one directed and one undirected. Calculate their density, which one is mode dense? 
"

# ╔═╡ 6551021e-e6d4-4d34-af80-efd8a7b3010d
md" ##
### 2.2.4 Average shortest path

In a real network like the Internet, a short average path length facilitates the quick transfer of information and reduces costs 

"

# ╔═╡ 36fdd2c2-2cc7-4288-a52f-f437c9dc72e2
Resource("https://i.ibb.co/5BBcHnv/path.png",:width => 400)

# ╔═╡ f3d4a1b2-ac40-49ec-a915-27780e6cbcf9
md"In networks, this path correpsonds to the path that information has to travel to go from one node to another. In other words, it corresponds to the number of links that separate two particular nodes. For instance, the shortest distance between node $0$ and node $7$ is "

# ╔═╡ 05a5f77d-84f5-41fc-8988-628d87ef3eca
md"
##
We can use this measure of the path to compare how important or central is each particular node in the network. Central nodes in the network are characterized by having a shortest distance to everyone else in the network than nodes located more at the boundaries. It is likely that information travels through this central nodes.

To calculate how central is a node, we need to calculate the shortest path of this particular node to all the nodes in the network. This is refered as the *average shortest path*. For instance, let's calculate the average shortest path of node 1, 2 and 0. Which one is more central?

"


# ╔═╡ 8a2c17b6-3f5c-4f9f-9714-09df2944dd50
#values_animals_4=DataFrame("Species" => ["A", "B", "C",  "D",  "E", "F", "G", "H", "I", "J"],"Frequency" => [33,33, 34, 0, 0, 0, 0, 0,0,0])

# ╔═╡ 4ace57bb-d9be-4681-8f7e-61982bb34b1c
Distance_to_2=DataFrame("Links" => ["2->1", "2->0", "2->3",  "2->7",  "2->4", "2->5", "2->6"],"Distance" => [1,2,3,4,4,5,5])

# ╔═╡ e66bd8db-cd2c-48b0-9734-60441a7341ee
md" The average shortest distance to node 2 is $(mean(Distance_to_2.Distance))"

# ╔═╡ 9179e620-b8ff-4559-b864-c9729a3a42ec
Distance_to_0=DataFrame("Links" => ["0->2", "0->1", "0->3",  "0->7",  "0->4", "0->5", "0->6"],"Distance" => [2,1,1,2,2,3,3])

# ╔═╡ 9c2a3452-8c7f-4f59-877f-a1c585107e0c
md" The average shortest distance to node 0 is $(mean(Distance_to_0.Distance)). "

# ╔═╡ ac539912-861a-4779-bac6-79c001177faa
paths_to_1=DataFrame("Links" => ["1->2", "1->0", "1->3",  "1->7",  "1->4", "1->6", "1->5"],"Distance" => [1,1,2,3,3,4,4])

# ╔═╡ bbe9efe4-13f7-45ee-9ab3-ebe46e4f744a
md" The average shortest distance to node 1 is $(mean(paths_to_1.Distance)) "

# ╔═╡ 33013fe2-e8da-48da-b67c-087f9363e782
path_0_to_7=[0,3,7]; distance_0_7=size(path_0_to_7)[1]-1;

# ╔═╡ 302cb412-ccd4-48a7-baad-4fb2d420ed6d
path_2_to_6=[2,1,0,3,4,6]; distance_2_6=size(path_2_to_6)[1]-1;

# ╔═╡ 76ece02b-8170-487b-8e0b-8e32b579b131
md"# 2.3 Matrix Representation of Networks

A network can be mathematically  represneted by a matrix, where rows and columns represent each of the nodes, and the values correspond to the interaction. This is called in network theory the __Adjacency Matrix__  $A$, and is a binary square matrix of $N$*$N$ elements. 

In particular:
$A_{ij}$ = 1 if there exists an interaction between $i$ and $j$ 
$A_{ij}$ = 0 if not. 
##
- for undirected networks  
```math 
A_{ij}  = A_{ji}, A_{ii} = 0
```
- and for directed networks 
```math 
A_{ij} \ne A_{ji}, A_{ii} = 0,
```
- and for directed networks with self-links
```math
A_{ij} \ne A_{ji}, A_{ii} \ne 0,
```





"

# ╔═╡ bc0d1ef0-1cea-4404-b470-5a8c853923b4
md"
## 
> __Task 3__: Draw and characterize the network that corresponds to the following graph:

```math
\begin{equation*}
A_{i,j} = 
\begin{pmatrix}
0 & 1 & 0 & 1 \\
1 & 0 & 1 & 0 \\
0  & 1  & 0 & 1  \\
1 & 0 & 1 &0 
\end{pmatrix}
\end{equation*}
```

## 
> __Task 4__: Draw and characterize the network that corresponds to the following graph:


```math
\begin{equation*}
A_{i,j} = 
\begin{pmatrix}
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1 \\
1  & 0  & 0 & 1  \\
0 & 1 & 0 & 0 
\end{pmatrix}
\end{equation*}
```

##
> __Task 5__:  Draw and characterize the network that corresponds to the following graph:


```math
\begin{equation*}
A_{i,j} = 
\begin{pmatrix}
0 & 1 & 0 & 1 \\
1 & 0 & 1 & 1 \\
0  & 1  & 0 & 0  \\
1 & 1 & 0 & 1 
\end{pmatrix}
\end{equation*}
```
Sometimes we might want to model a system where each connection is weighted by some numerical value. Let’s say we want to develop a version of Facebook where the frequency of interaction between any given pair of users influences the weight of their connection. If Alice and Bob are constantly sending messages and tagging each other in posts, then their connection is weighted more heavily. On the contrary, if they don’t interact much at all over Facebook, the underlying algorithm concludes they aren’t that close and will give their connection less weight.

"

# ╔═╡ 023bf61b-95f2-4704-a35c-3316c0a819f7
md"""##
!!! note
    From a graphical perspective, weighted networks are often represented with numerical labels in the links of the graph. This is why they are also called *labeled graphs*

"""

# ╔═╡ 98f85002-632a-4c5c-bff5-d5e99dc4a6da
Resource("https://mathcenter.oxford.emory.edu/site/cs171/directedAndEdgeWeightedGraphs/edge_weighted_graph.png", :width => 600)

# ╔═╡ cc38b0d4-3695-4167-892b-ccacc170cbca
md" ##
In the case of wheigthed networks, the adjacency matrix will simpy contain the wheights of each link in the corresponding rows and columns. 


> __Task 6__: Draw and characterize the network that corresponds to the following graph:

```math
\begin{equation*}
A_{i,j} = 
\begin{pmatrix}
0 & 2 & 0 & 2 \\
3 & 0 & 3 & 0 \\
0  & 4  & 0 & 2  \\
1 & 0 & 3 &0 
\end{pmatrix}
\end{equation*}
```

"

# ╔═╡ 8de6461d-e9ba-46df-a347-a7648b6f6e6a
#values_animals_3=DataFrame("Species" => ["A", "B", "C",  "D",  "E", "F", "G", "H", "I", "J"],"Frequency" => [72,9, 11, 10, 8, 12, 10,11,10,9])

# ╔═╡ f7f761c7-95c6-4730-a831-7d33fcab26ef
md"##"

# ╔═╡ ddd62a2f-b19d-41b7-8b56-3c279f9c61ab
md" # 2.4 Degree of Networks
Another more direct measure of how connect are the different nodes is the number of links they received. The degree $k$ of a node is the number of connections the node has to other nodes. If a network is directed, such as GRN, nodes have two different degrees:
- in-degree $k_{in}$: the number of incoming edges, and the 
- out-degree $k_{out}$:  the number of outgoing edges
- total-degree $k_{tot}$ = $k_{in}$ + $k_{out}$:
##
[![EC1wSj.md.png](https://iili.io/EC1wSj.md.png)](https://freeimage.host/i/EC1wSj)

_Undirected_:  
- degree of node 1 is 2
- degree of node 2 is 2  
- degree of node 3 is 3
- degree of node 4 is 1
##
In an undirected network the total number of links, E, can be expressed as the sum of the node degrees 

```math
\begin{align*}
E=\frac{1}{2}\sum_{i=1}^{N} k_i
\end{align*}
```

the 1/2 factor corrects for the fact that in the sum (2.1) each link is counted twice. For example, the link connecting the nodes 2 and 3 will be counted once in the degree of node 2 and once in the degree of node 3 
##
_Directed_:

- In-degree of node 1 is 0  
- In-degree of node 2 is 2
- Out-degree of node 1 is 2 
- Out degree of node 2 is 0

In a directed network the total number of links, E, can be expressed as the sum of all node in-degrees or out-degrees 

```math
\begin{align*}
E=\sum_{i=1}^{N} k_{in} = \sum_{i=1}^{N} k_{out}
\end{align*}
```

The __in__ degrees are:

```math
\begin{align*}
k^{in}_1 = 0\\
k^{in}_2 = 2\\
k^{in}_3 = 2\\
k^{in}_4 = 1
\end{align*}
```
##
The _out_ degrees are:
```math
\begin{align*}
k^{out}_1 = 2\\
k^{out}_2 = 0\\
k^{out}_3 = 2\\
k^{out}_4 = 1
\end{align*}
```
##
So, for this particular network:
```math
\begin{align*}
E=\sum_{i=1}^{N} k_{in} = \sum_{i=1}^{N} k_{out} =5
\end{align*}
```
"


# ╔═╡ 2db33033-cb6c-4e5b-b952-c9f06c98def0
md" ##
Using the adjacency matrix, the degree is the sum of the row 

For undirected:
```math
\begin{align*}
k_1=\sum_{i=1}^{N} A_{ij}
\end{align*}
```

For directed 
```math
\begin{align*}
k_{1}^{out}=\sum_{i=1}^{N} A_{ij}\\
k_{1}^{in}=\sum_{j=1}^{N} A_{ij}
\end{align*}
```
##
For weighted 
```math
\begin{align*}
k_{1}^{out}=\sum_{i=1}^{N} A_{ij}\\
k_{1}^{in}=\sum_{j=1}^{N} A_{ij}
\end{align*}
```
"

# ╔═╡ f938eda7-cefc-4ea3-991a-094b918d0430
Resource("https://i.ibb.co/7JVNCYn/adjacency.png")

# ╔═╡ 1d1f2e7d-8702-4d88-85c3-5ef3fb36c815
md"
##
> __Task 4__: Obtain the Adjacency matrices, degrees and average degree for each network: 
"

# ╔═╡ 689dc50a-784d-4efb-95c9-7582eb3e65a0
md"##"

# ╔═╡ b41588c9-c52c-4e85-ad1d-2775d143bd06
md" # 2.5 Average degree

The average number of links per node. Gives you a basic measurement of how the network is connected in average. 

In undirected networks:

```math
\begin{align*}
\left \langle k \right \rangle = \frac{k_1 + k_2+ k_3 + ... k_N}{N}=\frac{1}{N}\sum_{i=1}^{N}k_i=\frac{2E}{N}
\end{align*}
```

In directed networks:

```math
\begin{align*}
\left \langle k^{in}_i \right \rangle =\frac{1}{N}\sum_{i=1}^{N}k^{in}_i=\left \langle k^{out}_i \right \rangle =\frac{1}{N}\sum_{i=1}^{N}k^{out}_i=\frac{E}{N}
\end{align*}
```

using the notation of the adjacency matrix:
```math
\begin{align*}
\left \langle k \right \rangle =  \frac{ \sum_{i=j}^{N} \sum_{i=1}^{N} A_{ij}} {N}
\end{align*}
```
## 

As an example, let's compute the  average degree for the following networks: 

[![EC1wSj.md.png](https://iili.io/EC1wSj.md.png)](https://freeimage.host/i/EC1wSj)


For the undirected: $\left \langle k \right \rangle = (2+2+3+1)/ 4 = 2$ 

For the directed: $\left \langle k_{in} \right \rangle = (2+2+3+1)/ 4 = 2$ 

"

# ╔═╡ f8608e32-dda0-4eac-bac9-5d0a8e7ea4f4
md" # 2.6 Degree Distribution

The degree distribution $p_k$ provides the probability that a randomly selected node in the network has degree $p_{k}$. 
Since $p_{k}$ is a probability, it must be normalized, i.e.

```math
\begin{align*}
\sum_{k=1}^{N} p_k =1
\end{align*}
```

P(k) is the probability distribution of the degrees over the whole network.  pk of a network is defined as the fraction of nodes in the network with degree $k_i$. Thus if there are N nodes in total in a network and M of them have degree k, we have $p_{k}$ = M/N.
## 
The degree distribution is probably the most important feature of a network, since it determines many properties of how the network acts. So, the number of nodes in a network with degree k can be obtained by:


```math
\begin{align*}
N_k = N \cdot p_k
\end{align*}
```

And the average degree can be also calculated as:

```math
\begin{align*}
\left \langle k \right \rangle =\frac{1}{N}\sum_{i=1}^{N}k_i=\sum_{k=0}^{\infty }k \cdot p_k
\end{align*}
```

## 

We can characterize the networks based on the degree distribution:

"

# ╔═╡ d580711c-2aff-404c-9aa9-84d56759eac9
md"

##
- __Regular networks and trees__ (usually man-made, have the lowest heterogeneity (e.g. the number of connections each node has is more or less the same) 

- __small-world networks__ higher clustering and almost the same average path than the random networks with the same number of nodes and edges. high modularity, high herogeneity

- __Scale-free networks__ a highly heterogeneous degree distribution (power-law degree distribution)

- __Random networks__, nodes paired with uniform probability (low heterogeneity , since most nodes have the same number of connections), the degree distribution will be a Gaussian bell-shaped curve.

##


"

# ╔═╡ 227efe71-f57c-4c86-aa3b-3eacf570122b
Resource("https://i.ibb.co/DfvF9td/types-of-networks.jpg", :width => 400)

# ╔═╡ 454a7346-f7da-4228-af69-77091d2ff8d1
Resource("https://i.ibb.co/bz9tVtx/degree-distribution.jpg",:width=>400)

# ╔═╡ 96fe590a-6b2d-46a6-ac9e-133688eb9dbd
md"


The typical plot of the degree distribution of a random network as a maximum, which correspond to the characteristic scale of the network. For example, in this network, the characteristic scale is around 8, since there is a higher number of nodes with that number of connections. 
## 
Biological gene regulatory networks have a degree distribution very different from random. There is no characteristic scale (no node with a more common number of connections, no maximum in the degree distribution plot). Many nodes poorly connected, very few nodes (hubs) highly connected.

Degree distributions are often represented in log-log plot. These types of networks are called power-law or scale free networks 
##
Some non-biological networks also show a degree distribution that is close to scale free. Above we plot the degree distribution of some of them. 

(A) Actor collaboration graph with N = 212,250,〈k〉 = 28.78. 
(B) Small sample of the World Wide Web, N = 325,729, 〈k〉 = 5.46. 
(C) Power grid data, N = 4941, 〈k〉 = 2.67

What does it mean that so many real networks have a power law (scale free) degree distribution? 
As opposed to random networks, scale-free networks do not have a characteristic scale, meaning that there is no typical node in the network that represents the degree for the other nodes.
"

# ╔═╡ cf6802da-c4d0-41f7-a163-b0e40838dc02
md" # 2.7 Centrality: 

The centrality tells us which nodes are important in a network, based on the topological structure of the network (instead of just looking at the popularity of nodes). For instance, the centrality allows us to estimate several things:

- How influential a person is within a social network.
- Which genes play a crucial role in regulating systems and processes.
- Infrastructure networks: if the node is removed, it would critically impede the functioning of the network.

##

"

# ╔═╡ 230b7a34-ef94-4215-ba5a-670aa54fa334
Resource("https://imgur.com/Tht05fz.jpg",:width=>400)

# ╔═╡ cea7f35a-a265-462f-aa6e-83193580edd1
md" An illustration of why measurements of centrality are important, lets focus on the network depicted above. Here, nodes X and Z have higher degree (3) than node Y (2), but node Y is more central (to reach from one end to the other, information has to go through node Y)"

# ╔═╡ 9bc1261f-3dd4-426e-a1df-c23b60c8246b
md"
##

A first estimation of a centrality is the simply the Degree of the nodes. We will illustrate the concept with the following network.


"

# ╔═╡ 284e22a3-0bd4-4297-b70d-b609d7ca1cbb
Resource("https://imgur.com/3b1fIz3.jpg",:width=>200)

# ╔═╡ 89222e22-f0dc-4902-b188-944bab2b66dd
md"

We obtain three nodes (0,2 and 5) that are eually central based on the degree. This is one of the main weaknesses of finding the centrality of a network using just the degree: very likely we will find more than one vertex with the same degree. Therefore, it will be difficult to uniquely rank the nodes.

##
### 2.7.1 Eigenvector Centrality: 

A more robust and reliable method to rank how central is a node in a network is based on a method called *Eigenvector centrality*. In brief, it serves as an *importance score*, since it allows us to rank using the importance of the connections, so that connecting to some vertices has more benefit than connecting to others. In other words, a node may have fewer links, but if the nodes linking to the node have a lot of links, then it is an *important node*.



"

# ╔═╡ 0870ef44-32f6-4caa-a1c4-163423c9e0a2
md"""##
!!! reminder 

Let  𝐴  be a matrix with  𝑚  rows and  𝑛  columns. Consider the matrix equation  y = 𝐴 x. If we vary  x,  then  y  will also vary; in this way, we think of  𝐴  as a function with independent variable  x  and dependent variable  y.  In this context x and y are vectors and $A$ is a function that transforms the vector $x$ into the vector y. This trasnformation can be in modulus and/or direction. 

Since a matrix is a basically a function that transforms an input value into an output value, an Adjacency Matrix can be also seen as a transformation.

For instance, if $A$ is a 2×3  matrix, and 𝑥  is a vector in  ℝ3,   the output vector is $y$ in ℝ2, so the transformation is from 3D to 2D.  

```math
\begin{equation*}
A_{i,j} x = 
\begin{pmatrix}
1 & -1 & 2  \\
-2 & 2 & 4 
\end{pmatrix}
\begin{pmatrix}
-1  \\
2 \\
3
\end{pmatrix}
\begin{pmatrix}
3  \\
-6 \\
\end{pmatrix}
\end{equation*}
```

In the context of networks, the aqdjacency matrix tells you how a particular state of the system (for instance, number of individuals of each species) gets transformed into another one in the next iteration.

In this direction, eigenvectors mark the special directions where a particular state of the system, gets modified only in modulus and not in direction (i.e., transformation that preserve the balance between the species). Each eigenvector has associated an eigenvalue, which marks the specific amount that the species change in module. 

The direction of maximum change of module is called the Principal Eigenvector , and teh corresponding eigenvalue is called the Spectral Radius.



"""

# ╔═╡ c07fd387-2226-4d31-b6c7-647b68ddc5a3
md"""##
!!! reminder
	Let A be an nxn matrix. A scalar λ is called an Eigenvalue of A if there is a non- zero vector X such that AX = λX. Such a vector X is called an Eigenvector of A corresponding to λ

	For instance, the vector 
	```math
	\begin{equation*}
	X = 
	\begin{pmatrix}
	2 \\
	1 
	\end{pmatrix}
	\end{equation*}
	```
	is an Eigenvector of matrix A


	```math
	\begin{equation*}
	A = 
	\begin{pmatrix}
	3 & 2 \\
	3 & -2 
	\end{pmatrix}
	\end{equation*}
	```
	##
	because for λ=4, AX = λX, i.e., 
	```math
	\begin{equation*}
	\begin{pmatrix}
	3 & 2 \\
	3 & -2  \end{pmatrix} \cdot
	\begin{pmatrix}
	2  \\  1  \end{pmatrix} = 4 \cdot \begin{pmatrix}
	2  \\	1 	\end{pmatrix} 	\end{equation*}
	```
	## 
	since 

	```math
	\begin{equation*}  	
	\begin{pmatrix}
	3 \cdot 2 + 2 \cdot 1 \\
	3 \cdot 2  + -2 \cdot 1
	\end{pmatrix} \cdot =  
	\begin{pmatrix} 4 \cdot 2  \\
	4 \cdot 1  	\end{pmatrix} 
	\end{equation*}
	```
	##
	so 

	```math
	\begin{equation*}
 
	\begin{pmatrix}
	8 \\
	4
	\end{pmatrix} 
	 =  \begin{pmatrix}
	8  \\
	4 \end{pmatrix}\end{equation*}
	```


"""

# ╔═╡ 572b2320-da38-496a-b887-74d9e126936b
Resource("https://imgur.com/6UGqTtv.jpg",:width=>200)

# ╔═╡ e9b56ce6-c187-4910-96a1-abe06142f779
md""""
##
### 2.7.2 Finding Eigenvalues and Eigenvectors
Consider a matrix A

```math
\begin{equation*}
A = 
\begin{pmatrix}
7 & 3 \\
3 & -1 
\end{pmatrix}
\end{equation*}
```
##
Consider now A – λ I

```math
\begin{equation*}

\begin{pmatrix}
7 - \lambda & 3 \\
3 & -1 -\lambda
\end{pmatrix}
\end{equation*}
```
##
calculate the determinant
```math
\begin{equation*}

det \begin{pmatrix}
7 - \lambda & 3 \\
3 & -1 -\lambda
\end{pmatrix} = (7 - \lambda)\cdot (-1 -\lambda) - (3 \cdot 3) 
\end{equation*}
```
calculating
```math
\begin{equation*}
= -7 - 7 \lambda + \lambda + \lambda^2 - 9 =  \lambda^2 - 6 \lambda - 16
\end{equation*}
```
##
solving, we obtain that λ = 8 and λ = -2 are the Eigen values and λ = -2 are the Eigen values

so, for λ = 8, Consider A – λ I

```math
\begin{equation*}
\begin{pmatrix}
7 - 8 & 3 \\
3 & -1 -8
\end{pmatrix} = \begin{pmatrix}
-1 & 3 \\
3 & -9
\end{pmatrix}
\end{equation*}
```
##
now solve (A – λ I)X=0
```math
\begin{equation*}
\begin{pmatrix}
-1 & 3 \\
3 & -9
\end{pmatrix} \cdot \begin{pmatrix}
X_1 \\
X_2
\end{pmatrix} = \begin{pmatrix}
0 \\
0
\end{pmatrix} 
\end{equation*}
```
##
we have two equations

-$X_1$ + 3 $X_2$ = 0 and 3 $X_1$ – 9$X_2$ = 0

so, we obtain $X_1$ = 3 $X_2$, so , if we give value to $X_2$ = 1, then $X_1=3$, so the vector 

```math
\begin{equation*}
X=\begin{pmatrix}
3 \\
1
\end{pmatrix} 
\end{equation*}
```

is an eigenvector of the eigenvalue λ=8. Since this is the largest eigenvalue (also called the Spectral Radius), the eigenvector corresponding to this eigenvalue is called the Principal Eigenvector.



"""

# ╔═╡ 625a6e9d-a5bd-479d-92b7-3d0f99418e57
md" ##

### 2.7.3 Ranking based on eigenvector centrality 

We will now use this values to rank the centrality of the nodes based on the eigenvector. To do that we just need to first project the matrix into the ddirection of the unitary vector. We will use teh previously defined adjacencty matrix"

# ╔═╡ a69a69bd-5144-4000-9d97-9bb0b5076ebc
md" ##
The first step is as usual, to write the adjacency matrix:"

# ╔═╡ d225c248-81c8-4c58-8365-1a63ce2f58d3
ℳ = [0 1 1 1 0 0 0 0 ; 1 0 1 0 0 0 0 0 ;1 1 0 1 0 0 0 0; 1 0 1  0 1 0 0 0 ; 0 0 0 1 0 1 0 0; 0 0 0 0 1 0 1 1; 0 0 0 0 0 1 0 1;
0 0 0 0 0 1 1 0]

# ╔═╡ 25e8fb62-33b9-4474-8a4b-a9a7644888bf
md"we calculate the degree as:"

# ╔═╡ 9ad7502f-78aa-4913-87a4-262d4c3cbf31
projection_1= ℳ * [1, 1, 1, 1, 1, 1, 1, 1]

# ╔═╡ a4ffa944-c2a7-4414-8623-30cb8d48e103
md"##
Next, we project the adjacency matrix using this normalize vector"

# ╔═╡ b860a037-4afd-4433-8967-414e57bc4cdb
md"##
next, we normalize the vector obtained"


# ╔═╡ 3af821bc-7116-4182-a183-fb17afd84cc9
projection_1_normalized= projection_1 ./ norm(projection_1)

# ╔═╡ 77e5533e-239c-47e9-9ec2-ecf756b34faa
projection_2= ℳ * projection_1_normalized

# ╔═╡ 1aceabfb-e977-4526-a978-0a53da3a7d64
md"##
again, we normalize the projection"

# ╔═╡ ecd05ff0-9f72-43cb-aac0-8e3a3d5ed06c
projection_2_normalized= projection_2 ./ norm(projection_2)

# ╔═╡ f86ed936-3c2d-4f77-bcaa-a754aabd7126
begin
	struct Foldable{C}
	    title::String
	    content::C
	end
	
	function Base.show(io, mime::MIME"text/html", fld::Foldable)
	    write(io,"<details><summary>$(fld.title)</summary><p>")
	    show(io, mime, fld.content)
	    write(io,"</p></details>")
	end
end

# ╔═╡ 112377c7-bd58-4807-9807-e9a80c31231d
Foldable("Calculate the Richness of the previous ecosystem", md"The Richness R= $R.")

# ╔═╡ 12f0da42-ceac-42b6-9ea1-3eee51f22de5
Foldable("Calculate the dominance index of the previous ecosystem", md" The dominance index is $D.")

# ╔═╡ 682a7a48-348a-4967-bb00-12e54b346060
Foldable("Calculate the diversity index of the previous ecosystem", md" The diversity index  S= $S.")

# ╔═╡ 69bc6016-f7b9-4375-b3a8-8c01ea0f5d39
Foldable("Calculate the Evenness of the previous ecosystem", md"The evenness E= $E.")

# ╔═╡ 09d6e98f-623d-410d-8260-3c90a110767c
Foldable("The shortest distance between node 0 and node 7 is", md" Distance = $distance_0_7.")

# ╔═╡ 5341ae21-f313-4e16-949c-bccb84bac0a9
Foldable("The shortest distance between node 2 and node 6 is", md" Distance = $distance_2_6.")

# ╔═╡ e2b27bd7-cdcd-46a5-a87e-805a1e7d6850
ℳ * [1, 1, 1, 1, 1, 1, 1, 1]

# ╔═╡ 8ad284bb-9b21-4a04-aa33-d4c23a813010
begin
	projection_3= ℳ * projection_2_normalized
	projection_3_normalized= projection_3 ./ norm(projection_3)
	projection_4= ℳ * projection_3_normalized
	projection_4_normalized= projection_4 ./ norm(projection_4)
	projection_5= ℳ * projection_4_normalized
	projection_5_normalized= projection_5 ./ norm(projection_5)
	projection_6= ℳ * projection_5_normalized
	projection_6_normalized= projection_6 ./ norm(projection_6)
	projection_7= ℳ * projection_6_normalized
	projection_7_normalized= projection_7 ./ norm(projection_7)	
end

# ╔═╡ 2f714fc8-3f2e-485a-aa53-049713467a7f
md"##
the process is repeated until the norm of the projection converges to a given value (in this case we will do 7 iterations)"

# ╔═╡ f91c46e6-dd8c-406a-ace1-c0c21b3eeb60
md"##
Now we can rank the centrality of the nodes based on the components of the eignevector. It is clear that nodes 0 and 2 in the graph are equally central.

In conclusion, Eigenvector centrality specifically weights nodes based on their degree of connection. It does so by counting both the number and the quality of connections (connections are more important if they connect to a node with many connections). This way, a node with few connections to some high-ranking other nodes may outrank one with a larger number of mediocre contacts.

##
### 2.7.4 Eigen Vector centrality for directed graphs

The PageRank algorithm used by Google's search engine is a variant of Eigenvector Centrality for directed networks.

Now, we can use the Eigen Vector centrality to evaluate the “importance” of a node (based on the out-degree Eigen Vector) and the “prestige” of a node (through the in-degree Eigen Vector)

##
- A node is considered to be more important if it has out-going links to nodes that in turn have a larger out-degree (i.e., more out-going links).
- A node is considered to have a higher “prestige”, if it has in-coming links from nodes that themselves have a larger in-degree (i.e., more in-coming links)

- Hub: Node that points to lots of pages (Pubmed, out-degree)
- Authority: Node to which several other nodes point to (the genome paper, in-degree)
- Good *authority* and *hub* pages reinforce one another

" 

# ╔═╡ 3b9d8c45-fd93-4e51-ac27-f7fd991d703c
md"#"

# ╔═╡ d060c964-98be-419b-9ba8-0114a4b0444d
md"

# 2.8 Conclusions: 
The study of Networks is a very big, active and interesting field. The characteristics of networks of interactions are quite useful to understand key properties of large systems where their parts are interacting (big data…). Biological networks are a perfect systems to study using this formalism of network theory. It is well known that most of biologically occurring networks  have a degree distribution close to scale free, characterized by the presence of large hubs:

These power law distributions have the same functional form at all scales.
Why so many different systems have the same scale free degree distribution?
##t
This is quite difficult question to try to explain in such a basic course. But the current agreement is that Scale Free networks often apear in  in systems where you have two properties combined:

 They grow in size (new nodes and links added). They started from small networks and became large by adding new nodes (as oppose to networks were all the links are established at the same time, i.e., a group in WhatsApp)
There is some sort of “preferential attachment”, meaning that there is some popular nodes that every one wants to get information from (rich gets richer)

Both social networks and GRN have these two properties. 
"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "2a722f9bb2798ffdc78073562afd961278e90837"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "0fb305e0253fd4e833d486914367a2ee2c2e78d0"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.0.1"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "c5aeb516a84459e0318a02507d2261edad97eb75"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.7.1"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "0c5f81f47bbbcf4aea7b2959135713459170798b"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.5"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "601f7e7b3d36f18790e2caf83a882d88e9b71ff1"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.4"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "ad25e7d21ce10e01de973cdc68ad0f850a953c52"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.21.1"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "70232f82ffaab9dc52585e0dd043b5e0c6b714f1"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.12"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "9ebb045901e9bbf58767a9f34ff89831ed711aae"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.7"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "59939d8a997469ee05c4b4944560a820f9ba0d73"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.4"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "75bd5b6fc5089df449b5d35fa501c846c9b6549b"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.12.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "9c4708e3ed2b799e6124b5673a712dda0b596a9b"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.3.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "04c738083f29f86e62c8afc341f0967d8717bdb8"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.6.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "ac67408d9ddf207de5cfa9a97e114352430f01ed"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.16"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "66c4c81f259586e8f002eacebc177e1fb06363b0"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.11"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "4820348781ae578893311153d69049a93d05f39d"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "c5c28c245101bd59154f649e19b038d15901b5dc"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "8e2d86e06ceb4580110d9e716be26658effc5bfd"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.8"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "da121cbdc95b065da07fbb93638367737969693f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.8+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "e94c92c7bf4819685eb80186d51c43e71d4afa17"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.76.5+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "899050ace26649433ef1af25bc17a815b3db52b7"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.9.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "abbbb9ec3afd783a7cbd82ef01dcd088ea051398"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.1"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HistogramThresholding]]
deps = ["ImageBase", "LinearAlgebra", "MappedArrays"]
git-tree-sha1 = "7194dfbb2f8d945abdaf68fa9480a965d6661e69"
uuid = "2c695a8d-9458-5d45-9878-1b8a99cf7853"
version = "0.3.1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "eb8fed28f4994600e29beef49744639d985a04b2"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.16"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageBinarization]]
deps = ["HistogramThresholding", "ImageCore", "LinearAlgebra", "Polynomials", "Reexport", "Statistics"]
git-tree-sha1 = "f5356e7203c4a9954962e3757c08033f2efe578a"
uuid = "cbc4b850-ae4b-5111-9e64-df94c024a13d"
version = "0.3.0"

[[deps.ImageContrastAdjustment]]
deps = ["ImageBase", "ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "eb3d4365a10e3f3ecb3b115e9d12db131d28a386"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.12"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "b2a7eaa169c13f5bcae8131a83bc30eff8f71be0"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.2"

[[deps.ImageCorners]]
deps = ["ImageCore", "ImageFiltering", "PrecompileTools", "StaticArrays", "StatsBase"]
git-tree-sha1 = "24c52de051293745a9bad7d73497708954562b79"
uuid = "89d5987c-236e-4e32-acd0-25bd6bd87b70"
version = "0.1.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "08b0e6354b21ef5dd5e49026028e41831401aca8"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.17"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "PrecompileTools", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "432ae2b430a18c58eb7eca9ef8d0f2db90bc749c"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.8"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "bca20b2f5d00c4fbc192c3212da8fa79f4688009"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.7"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "b0b765ff0b4c3ee20ce6740d843be8dfce48487c"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.3.0"

[[deps.ImageMagick_jll]]
deps = ["JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1c0a2295cca535fabaf2029062912591e9b61987"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.10-12+3"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "6f0a801136cb9c229aebea0df296cdcd471dbcd1"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.5"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "3ff0ca203501c3eedde3c6fa7fd76b703c336b5f"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.2"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "e0884bdf01bbbb111aea77c348368a86fb4b5ab6"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.1"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "d438268ed7a665f8322572be0dabda83634d5f45"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.0"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3d09a9f60edf77f8a4d99f9e015e8fbf9989605d"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.7+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "ea8031dea4aff6bd41f1df8f2fdfb25b33626381"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.4"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5fdf2fe6724d8caabf43b557b84ce53f3b7e2f6b"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.0.2+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "88a101217d7cb38a7b481ccd50d21876e1d1b0e0"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.15.1"
weakdeps = ["Unitful"]

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "PrecompileTools", "Printf", "Reexport", "Requires", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "7c0008f0b7622c6c0ee5c65cbc667b69f8a65672"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.45"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60b1194df0a3298f460063de985eae7b01bc011a"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.1+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "62edfee3211981241b57ff1cedf4d74d79519277"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.15"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "0f5648fbae0d015e3abe5867bca2b362f67a5894"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.166"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "72dc3cf284559eb8f53aa593fe62cb33f83ed0c0"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.0.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "1130dbe1d5276cb656f6e1094ce97466ed700e5a"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "ded64ff6d4fdd1cb68dfcbb818c69e144a5b2e4c"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.16"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "6a731f2b5c03157418a20c12195eb4b74c8f8621"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.13.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "a4ca623df1ae99d09bc9868b008262d0c0ac1e4f"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a12e56c72edee3ce6b96667745e6cbbe5498f200"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "862942baf5663da528f66d24996eb6da85218e76"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "c4fa93d7d66acad8f6f4ff439576da9d2e890ee0"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.1"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "68723afdb616445c6caaef6255067a8339f91325"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.55"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "240d7170f5ffdb285f9427b92333c3463bf65bf6"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.1"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase"]
git-tree-sha1 = "3aa2bb4982e575acd7583f01531f241af077b163"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "3.2.13"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    MakieCore = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "88b895d13d53b5577fd53379d913b9ab9ac82660"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "00099623ffee15972c16111bcf84c58a0051257c"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.9.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "994cc27cdacca10e68feb291673ec3a76aa2fae9"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.6"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "2a0a5d8569f481ff8840e3b7c84bbf188db6a3fe"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.7.0"
weakdeps = ["RecipesBase"]

    [deps.Rotations.extensions]
    RotationsRecipesBaseExt = "RecipesBase"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "3aac6d68c5e57449f5b9b865c9ba50ac2970c4cf"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.42"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "0e7508ff27ba32f26cd459474ca2ede1bc10991f"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "4b33e0e081a825dbfaf314decf58fa47e53d6acb"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "d2fdac9ff3906e27f7a618d47b676941baa6c80c"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.8.10"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Requires", "SparseArrays", "Static", "SuiteSparse"]
git-tree-sha1 = "5d66818a39bb04bf328e92bc933ec5b4ee88e436"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.5.0"
weakdeps = ["OffsetArrays", "StaticArrays"]

    [deps.StaticArrayInterface.extensions]
    StaticArrayInterfaceOffsetArraysExt = "OffsetArrays"
    StaticArrayInterfaceStaticArraysExt = "StaticArrays"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "7b0e9c14c624e435076d19aea1e5cbdec2b9ca37"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.2"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "cb76cf677714c095e535e3501ac7954732aeea2d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.11.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "34cc045dd0aaa59b8bbe86c644679bc57f1d5bd0"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.8"

[[deps.TiledIteration]]
deps = ["OffsetArrays", "StaticArrayInterface"]
git-tree-sha1 = "1176cc31e867217b06928e2f140c90bd1bc88283"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.5.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "54194d92959d8ebaa8e26227dbe3cdefcdcd594f"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.3"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "7209df901e6ed7489fe9b7aa3e46fb788e15db85"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.65"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "801cbe47eae69adc50f36c3caec4758d2650741b"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.2+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "93284c28274d9e75218a416c65ec49d0e0fcdf3d"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.40+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─5dba5e73-390a-49ca-8c75-541d3299a741
# ╟─45ad05da-4f14-426b-a497-52c63b0f0b2e
# ╟─137f51d2-c6e1-4d39-a8c7-3c1f850ae1d2
# ╟─e474a63a-91e4-4ec0-b301-e3b1b261fc28
# ╟─0ebe3384-97aa-11ec-17b5-cbf23568df03
# ╟─35524d0e-64ce-4020-a6db-e3b6ea71a777
# ╟─8ad237fa-8a09-4bae-80f4-ba1298c09581
# ╟─bee1dd58-c8e6-4fa6-8eae-7cd4cca0a466
# ╟─ee9bef40-165f-4e26-8ee3-f2b96945bbc9
# ╟─279b1402-f4ba-4a3b-9d7d-82ac81b515e4
# ╟─4190734c-4c6e-4662-9be9-2c19c4956a38
# ╟─9981448a-edee-435f-9d2b-ec3271c4016a
# ╟─112377c7-bd58-4807-9807-e9a80c31231d
# ╟─c5216253-b818-4ea9-bba7-af8eeb6fd619
# ╟─12f0da42-ceac-42b6-9ea1-3eee51f22de5
# ╟─ffb98383-a88f-4a42-bf3f-e5709f98b143
# ╟─3989ead3-2760-443f-80e8-21ac961e2ff5
# ╟─682a7a48-348a-4967-bb00-12e54b346060
# ╟─67091769-33dc-4b16-97b5-b817bf3699ec
# ╠═8f31e31d-1080-4b22-b508-b71bf30c2ec0
# ╟─69bc6016-f7b9-4375-b3a8-8c01ea0f5d39
# ╟─e6de7170-8b6f-4cf7-bd44-a8550486927d
# ╟─5be26bca-bb7d-42d1-9fc8-d589d21ee9ff
# ╟─721ad120-8999-4f9f-9bd3-b9d966246436
# ╟─b20cdd19-08c4-4837-947f-97594b8822d2
# ╟─73f4fd5b-4611-4d90-8f05-af7b279dd86a
# ╟─2180acb2-a298-4c87-8851-2fc5e322b51e
# ╟─40f52fcb-4be1-40c1-8720-ee48433473f3
# ╟─ca9e7ee2-4a28-49da-994a-b721929882ec
# ╟─af0276a5-322a-4a7f-9457-7e58524c5cbd
# ╟─d4c87e16-8dff-4818-9bfc-df89c372a498
# ╟─477ba0d8-1dd9-46c8-bff0-72e4bfa89238
# ╟─6551021e-e6d4-4d34-af80-efd8a7b3010d
# ╟─36fdd2c2-2cc7-4288-a52f-f437c9dc72e2
# ╟─f3d4a1b2-ac40-49ec-a915-27780e6cbcf9
# ╟─09d6e98f-623d-410d-8260-3c90a110767c
# ╟─5341ae21-f313-4e16-949c-bccb84bac0a9
# ╟─05a5f77d-84f5-41fc-8988-628d87ef3eca
# ╟─8a2c17b6-3f5c-4f9f-9714-09df2944dd50
# ╟─4ace57bb-d9be-4681-8f7e-61982bb34b1c
# ╟─e66bd8db-cd2c-48b0-9734-60441a7341ee
# ╟─9179e620-b8ff-4559-b864-c9729a3a42ec
# ╟─9c2a3452-8c7f-4f59-877f-a1c585107e0c
# ╟─ac539912-861a-4779-bac6-79c001177faa
# ╟─bbe9efe4-13f7-45ee-9ab3-ebe46e4f744a
# ╟─33013fe2-e8da-48da-b67c-087f9363e782
# ╟─302cb412-ccd4-48a7-baad-4fb2d420ed6d
# ╟─76ece02b-8170-487b-8e0b-8e32b579b131
# ╟─bc0d1ef0-1cea-4404-b470-5a8c853923b4
# ╟─023bf61b-95f2-4704-a35c-3316c0a819f7
# ╟─98f85002-632a-4c5c-bff5-d5e99dc4a6da
# ╟─cc38b0d4-3695-4167-892b-ccacc170cbca
# ╟─8de6461d-e9ba-46df-a347-a7648b6f6e6a
# ╟─f7f761c7-95c6-4730-a831-7d33fcab26ef
# ╟─ddd62a2f-b19d-41b7-8b56-3c279f9c61ab
# ╟─2db33033-cb6c-4e5b-b952-c9f06c98def0
# ╟─f938eda7-cefc-4ea3-991a-094b918d0430
# ╟─1d1f2e7d-8702-4d88-85c3-5ef3fb36c815
# ╟─689dc50a-784d-4efb-95c9-7582eb3e65a0
# ╟─b41588c9-c52c-4e85-ad1d-2775d143bd06
# ╟─f8608e32-dda0-4eac-bac9-5d0a8e7ea4f4
# ╟─d580711c-2aff-404c-9aa9-84d56759eac9
# ╟─227efe71-f57c-4c86-aa3b-3eacf570122b
# ╟─454a7346-f7da-4228-af69-77091d2ff8d1
# ╟─96fe590a-6b2d-46a6-ac9e-133688eb9dbd
# ╟─cf6802da-c4d0-41f7-a163-b0e40838dc02
# ╟─230b7a34-ef94-4215-ba5a-670aa54fa334
# ╟─cea7f35a-a265-462f-aa6e-83193580edd1
# ╟─9bc1261f-3dd4-426e-a1df-c23b60c8246b
# ╟─284e22a3-0bd4-4297-b70d-b609d7ca1cbb
# ╟─89222e22-f0dc-4902-b188-944bab2b66dd
# ╟─0870ef44-32f6-4caa-a1c4-163423c9e0a2
# ╟─c07fd387-2226-4d31-b6c7-647b68ddc5a3
# ╟─572b2320-da38-496a-b887-74d9e126936b
# ╟─e9b56ce6-c187-4910-96a1-abe06142f779
# ╟─625a6e9d-a5bd-479d-92b7-3d0f99418e57
# ╟─a69a69bd-5144-4000-9d97-9bb0b5076ebc
# ╟─d225c248-81c8-4c58-8365-1a63ce2f58d3
# ╟─25e8fb62-33b9-4474-8a4b-a9a7644888bf
# ╟─9ad7502f-78aa-4913-87a4-262d4c3cbf31
# ╟─a4ffa944-c2a7-4414-8623-30cb8d48e103
# ╟─b860a037-4afd-4433-8967-414e57bc4cdb
# ╟─3af821bc-7116-4182-a183-fb17afd84cc9
# ╠═77e5533e-239c-47e9-9ec2-ecf756b34faa
# ╟─1aceabfb-e977-4526-a978-0a53da3a7d64
# ╟─ecd05ff0-9f72-43cb-aac0-8e3a3d5ed06c
# ╟─f86ed936-3c2d-4f77-bcaa-a754aabd7126
# ╠═e2b27bd7-cdcd-46a5-a87e-805a1e7d6850
# ╟─8ad284bb-9b21-4a04-aa33-d4c23a813010
# ╟─2f714fc8-3f2e-485a-aa53-049713467a7f
# ╟─f91c46e6-dd8c-406a-ace1-c0c21b3eeb60
# ╟─3b9d8c45-fd93-4e51-ac27-f7fd991d703c
# ╟─d060c964-98be-419b-9ba8-0114a4b0444d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
