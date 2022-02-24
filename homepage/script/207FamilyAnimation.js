const family = document.getElementById("animContainer");
const familyStand = document.getElementById("207FamilyStand");
const familyAnim1 = document.getElementById("207FamilyAnim1");
const familyAnim2 = document.getElementById("207FamilyAnim2");
const familyAnim3 = document.getElementById("207FamilyAnim3");
const camionAnim1 = document.getElementById("camionCote1");
const camionAnim2 = document.getElementById("camionCote2");
var move = false;
var camionIntervId;
var familyIntervId;

function familyStandBy() {
    familyStand.style.visibility = "visible";
    familyAnim1.style.visibility = "hidden";
    familyAnim2.style.visibility = "hidden";
    familyAnim3.style.visibility = "hidden";
    camionAnim1.style.visibility = "hidden";
    camionAnim2.style.visibility = "hidden";
}

familyStandBy();

function animFamilyRight() {

    if (familyAnim1.style.visibility == "visible")
    {
        familyAnim1.style.visibility = "hidden";
        familyAnim2.style.visibility = "visible";
        familyAnim3.style.visibility = "hidden";
        checkMove();
    }

    else if (familyAnim2.style.visibility == "visible")
    {
        familyAnim1.style.visibility = "hidden";
        familyAnim2.style.visibility = "hidden";
        familyAnim3.style.visibility = "visible";
        checkMove();
    }

    else if (familyAnim3.style.visibility == "visible")
    {
        familyAnim1.style.visibility = "visible";
        familyAnim2.style.visibility = "hidden";
        familyAnim3.style.visibility = "hidden";
        checkMove();
    }
}

function animCamionRight() {
    if (familyStand.style.visibility == "visible")
    {
        familyStand.style.visibility = "hidden";
        camionAnim1.style.visibility = "visible";
        familyAnim1.style.visibility = "visible";
        checkMove();
    }

    else if (camionAnim1.style.visibility == "visible")
    {
        camionAnim1.style.visibility = "hidden";
        camionAnim2.style.visibility = "visible";
        checkMove();
    }

    else {
        camionAnim1.style.visibility = "visible";
        camionAnim2.style.visibility = "hidden";
        checkMove();
    }
}

function checkMove() {
    let posFamily = family.getBoundingClientRect();
    if (move == true) {
        if (posFamily.x == -109)
        {
            familyStandBy();
            stopMove();
            move = false;
        }
        else {
            camionIntervId = setInterval(animCamionRight, 200);
            familyIntervId = setInterval(animFamilyRight, 500);
            setInterval(animCamionRight, 200);
            setInterval(animFamilyRight, 500);
        }
    }
    else {
        familyStandBy();
        stopMove();
    }
}

function moveRight() {
    move = true;
    animCamionRight();
    animFamilyRight();
    checkMove();
    /*Ici, il faudrait que cela déplace de +30px à chaque fois */
    family.style.transform = "translate(30px, 0px)";
}

function stopMove() {
    clearInterval(camionIntervId);
    clearInterval(familyIntervId);
}

setInterval(moveRight, 5000);