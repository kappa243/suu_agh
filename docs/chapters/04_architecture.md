# Architecture

## Solution architecture
<!---
taka rozpiska na razie (pewnie wszystko do zmiany)
--->
We are planning to have a bookstore service on clusters <!--(to na pewno zmienić).

There are 2 clusters (one on AWS an other on AZURE) that provide access to book database by:
* Having an shop service (not functional, but client can view all books)
* An api that supports GET and POST methods.

The load is spread evenly by Load Balancer.

The 2 clusters have an access to single SQL database, which keeps all the book data.
Load balancer and database are hosted on the same machine (main server).

<img src="./../_img/fast_diagram.drawio.png" alt="image" width="500" height="auto">

## Technology

The bookstore applications responsible for "shop", "api" are written in Ruby.
Each of these services and the MySQL database are <!--(nie wiem jak po angielsku to powiedzieć "postawione" xD)--> on different docker container.

<!--(w sumie to nie wiem co z hubem tutaj)-->