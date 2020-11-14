---
title: Binary Trees
tags: algorithms, data_structures
---


- [Background]
    - Hierarchical In nature  
    - Max number of Nodes at any level apart from root is {{ }}$$ 2^i $${{ }}  where i is the {{ level }}
    - ![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/binaryTree.bmp)
    - The depth of the Node:: is the distance from the root to the Node
    - The height of a node is the:: number of edges from node to the deepest leaf
    - height of tree == height of the root node
- [Properties]
    - Max number of nodes is:: 
        - $$2^h - 1$$ 
        - $$a => bs$$

- **Traversals**
    - Traversal is a process to:: visit all the nodes in a tree
    - Two Types:
        - Depth First Traversal
            - Preorder Traversal ?:: visit the parent first and then left and right
            - Inorder Traversal ?:: visit the left first then parent and then right
            - Postorder Traversal ?:: visit left first then right and finally parent
        - Breadth First Traversal
            - Level traversal ?:: All the nodes at the same level are visited first
        - Following Example shows all the above traversals with a diagram: :: 
            - PreOrder - 8, 5, 9, 7, 1, 12, 2, 4, 11, 3
            - InOrder - 9, 5, 1, 7, 2, 12, 8, 4, 3, 11
            - PostOrder - 9, 1, 2, 12, 7, 5, 3, 11, 4, 8
            - LevelOrder - 8, 5, 4, 9, 7, 11, 1, 12, 3, 2
            - ![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/tree1.bmp)
- [Type]
- [Operations]
    - There are {{ 3 }} operations in a binary or binary search tree
        - Search
            - Starts at ?:: root
            - is {{ recursive }}
            - complexity is:: 
            - if node is found return node, if not then move to the right
        - Insert
            - Starts At ?:: root
            - Recurse to a potential position and insert it.
            - complexity is:: 
        - Delete
            - complexity is:: 
                - Average Time ?:: $$ O(log_{2} N) $$
                - Worst case ?:: $$ O(N) $$
            - Deletion is tricky because ?:: any deletion with a node that is not leaf will cause the creation of a subtree and the tree might need to be rebalanced.[^1]

        [^1]:
        This is what it is

- [Code]

``` haskell

                data BinaryTree a = Leaf |
                    Node (BinaryTree a) a (BinaryTree a)
                        deriving (Show, Eq, Ord)

                insert' b Leaf =  Node Leaf b Leaf
                insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
                insert' b (Node left a right)
                    | b == a = Node left a right
                    | b < a = Node (insert' b left) a right
                    | b > a = Node left a (insert' b right)

```