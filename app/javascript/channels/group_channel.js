 import consumer from "./consumer"
// consumer.subscriptions.create(
//     {channel: "GroupChannel", group_id: },
//    {
//   connected() {
//     // Called when the subscription is ready for use on the server
//     console.log("Connected to the room olasjfdlj!");
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   received(data) {
//     // Called when there's incoming data on the websocket for this channel
//     console.log("Recieving:")
//     $(".chat").prepend(data)
//   }
// });


$(document).ready(function(){
    var $element = $('.group-chat-channel'),
        group_id = $element.data('group-id'),
        messageTemplate = $('[data-role="message-template"]');

    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)

    consumer.subscriptions.create(
      {
        channel: "GroupChannel",
        group: group_id
      },
      {
        received: function(data) {
          var content = messageTemplate.children().clone(true, true);
          content.find('[data-role="message-user"]').text(data.user.name);
          content.find('[data-role="message-text"]').text(data.message.body);
          content.find('[data-role="message-date"]').text(data.message.updated_at);
          $element.append(content);
          $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
          $('#new_message [name="message[body]"]').val("");
        }
      }
    );
});
