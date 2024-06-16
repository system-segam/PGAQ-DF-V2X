SELECT o_custkey, MAX(l_quantity) FROM lineitem
INNER JOIN orders ON lineitem.l_orderkey = orders.o_orderkey
GROUP BY o_custkey;