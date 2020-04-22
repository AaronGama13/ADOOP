/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function validarNum() {
    var precio = document.getElementById("precioo").value;
    var stock = document.getElementById("stockk").value;
    console.log(precio);
    console.log(stock);

    if(isNaN(precio)) {
        alert("No puedes ingresar texto en precio, solo numeros");
        return false;
    }
    else if(precio < 0) {
        alert("No puedes ingresar cantidades negativas");
        return false;
    }
    else if(isNaN(stock)) {
        alert("No puedes ingresar texto en stock, solo numeros");
        return false;
    }
    else if(stock < 0) {
        alert("No puedes ingresar cantidades negativas");
        return false;
    }
}