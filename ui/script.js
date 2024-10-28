
window.addEventListener('message', function(event) {
    const action = event.data.action; 
    if (action === 'openPauseMenu') {
        openPauseMenu(event.data.balance, event.data.wallet, event.data.dirtyMoney, event.data.playerName, event.data.jobName, event.data.sex); 
    } 
});

function updatePlayerInfo(index, icon, label, value) {
    $('.contenitore_info_player .player-info-item').eq(index).html(`<i class="${icon}"></i> <strong>${label}</strong> ${value}`);
}

function openPauseMenu(balance, wallet, dirtyMoney, playerName, jobName, sex) { 
    // console.log('Open action');
    $('body').fadeIn();

    updatePlayerInfo(0, 'fas fa-user', 'Name:', playerName);
    updatePlayerInfo(1, 'fas fa-briefcase', 'Job:', jobName);
    updatePlayerInfo(2, 'fas fa-venus-mars', 'Gender:', sex); 
    updatePlayerInfo(3, 'fa-solid fa-piggy-bank', 'Balance:', `$${balance}`);
    updatePlayerInfo(4, 'fas fa-dollar-sign', 'Wallet:', `$${wallet}`);
    updatePlayerInfo(5, 'fa-solid fa-sack-dollar', 'Dirty:', `$${dirtyMoney}`); 
}


document.onkeydown = function (event) {
    event = event || window.event;
    if (event.keyCode === 27) {
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
        closePauseMenu()
    }
};

function closePauseMenu() {
    // console.log('Close action');
    $('body').fadeOut();
}

$(document).ready(function() {

    let resourceName = "krs_pausemenu"; 
    
    $(".contenitore_mappa").click(function() {
        // console.log('Map open');
        $.post(`https://${resourceName}/map`, JSON.stringify({}), function(response) {
            $('body').fadeOut();
            console.log(response);
        });
    });
    $(".contenitore_settings").click(function() {
        // console.log('Settings open');
        $.post(`https://${resourceName}/settings`, JSON.stringify({}), function(response) {
            $('body').fadeOut();
            console.log(response);
        });
    });
    $(".contenitore_relog").click(function() {
        // console.log('Relog');
        $.post(`https://${resourceName}/relog`, JSON.stringify({}), function(response) {
            $('body').fadeOut();
            console.log(response);
        });
    });
    $(".contenitore_logout").click(function() {
        // console.log('Logout');
        $.post(`https://${resourceName}/logout`, JSON.stringify({}), function(response) {
            console.log(response);
        });
    });
});
