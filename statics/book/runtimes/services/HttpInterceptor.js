define(['app'], function(app){
  app.factory('HttpInterceptor', function() {
      // ---
      // PRVIATE METHODS.
      // ---
      // I serialize the given Object into a key-value pair string. This
      // method expects an object and will default to the toString() method.
      // --
      // NOTE: This is an atered version of the jQuery.param() method which
      // will serialize a data collection for Form posting.
      // --
      // https://github.com/jquery/jquery/blob/master/src/serialize.js#L45
      function serializeData(data) {
        // If this is not an object, defer to native stringification.
        if (!angular.isObject(data)) {
          return ((data == null) ? "" : data.toString());
        }
        var buffer = [];
        // Serialize each key in the object.
        for (var name in data) {
          if (!data.hasOwnProperty(name)) {
            continue;
          }
          var value = data[name];
          buffer.push(
            encodeURIComponent(name) +
            "=" +
            encodeURIComponent((value == null) ? "" : value)
          );
        }
        // Serialize the buffer and clean it up for transportation.
        var source = buffer
          .join("&")
          .replace(/%20/g, "+");
        return (source);
      }
      return {
        request: function(config) {
          if (config.method === 'POST') {
            if (config.data && !config.data.pureJSON) {
              config.headers = config.headers || {};
              config.headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8";
              config.data = serializeData(config.data);
            }
          }
          return config;
        }
      };
    })
});