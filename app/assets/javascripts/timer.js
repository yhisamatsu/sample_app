var btn = document.getElementById("btnID");
var cnt = document.getElementById("cntID");

var label = "Count: ";
var count_max = 140;

var stop = false;
var count = count_max;

function initCount() {
    stop = false;
    count = count_max;
    cnt.innerHTML = label + count_max;
    btn.innerHTML = "Start Count";
}

function updateCount(count) {
    cnt.innerHTML = label + count;
}

function countDown() {
    if (count <= 0) {
        if (stop) {      // countdown interrupted
            initCount();
        } else {         // countdown finished
            cnt.innerHTML = "Finish!";
            btn.innerHTML = "Reset";
        }
    } else {             // recursion with setting a timer
        setTimeout(function() {
            count -= 1;
            updateCount(count);
            countDown()
        }, 1000);
    }
}

function startCount() {
    if (count == 0) {
        initCount();
    } else if (count < count_max) {
        stop = true;
        count = 0;
        btn.innerHTML = "Start Count";
    } else {
        btn.innerHTML = "Stop";
        countDown();
    }
}

initCount();