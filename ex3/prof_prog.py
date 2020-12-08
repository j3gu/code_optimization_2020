def remove_dup(lista):
    lista2 = []
    if lista:
        for item in lista:
            if item not in lista2:
                lista2.append(item)
    else:
        return lista2
    
    return lista2


for i in range(0,50000):
    print(remove_dup([1,2,3,3]))


