class App {
    static init() {
        var progressbar = $("#progressbar"),
            bar         = progressbar.find('.uk-progress-bar'),
            settings    = {
                action: '/upload',
                allow: '*.*',
                params: {
                    "_csrf_token": $('#_csrf_token').val()
                },
                loadstart: function() {
                    bar.css("width", "0%").text("0%");
                    progressbar.removeClass("uk-hidden");
                },
                progress: function(percent) {
                    percent = Math.ceil(percent);
                    bar.css("width", percent+"%").text(percent+"%");
                },
                complete: function(response) {
                    //Upload complete
                    //document.write(response);
                    response = JSON.parse(response);
                    var elem = '';
                    if (response.error) {
                        elem = '<div class="uk-alert uk-alert-danger"><p>' + response.error + '</p></div>';
                    } else {
                        var url = "http://" + response.url + "/" + response.filename;
                        elem = '<div class="uk-alert uk-alert-success"><p><a href="' + url + '" target="_blank">' + url  + '</a></p></div>';
                    }
                    $('#uploaded-files').append(elem);
                },
                allcomplete: function(response) {
                    bar.css("width", "100%").text("100%");
                    setTimeout(function() {
                        progressbar.addClass("uk-hidden");
                    }, 250);
                }
            };
        var select = UIkit.uploadSelect($("#upload-select"), settings),
            drop   = UIkit.uploadDrop($("#upload-drop"), settings);
    }
};

$( () => App.init() )

export default App

