<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<body>
<script src="/sources/js/sockjs.min.js"></script>
<script src="/sources/js/stomp.min.js"></script>
<script>


        var stompClient = null;
        function setConnected(connected) {
            document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;
            document.getElementById('conversationDiv').style.visibility = connected ? 'visible' : 'hidden';
            document.getElementById('response').innerHTML = '';
        }
        // 开启socket连接
        function connect() {
            var socket = new SockJS('/socket');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                setConnected(true);
            });
        }
        // 断开socket连接
        function disconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
            setConnected(false);
            console.log("Disconnected");
        }
        // 向‘/app/change-notice’服务端发送消息
        function sendName() {
            var value = document.getElementById('name').value;
            stompClient.send("/app/change-notice", {}, value);
        }
        connect();

</script>
<div>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button>
    </div>
    <div id="conversationDiv">
        <p>
            <label>notice content?</label>
        </p>
        <p>
            <textarea id="name" rows="5"></textarea>
        </p>
        <button id="sendName" onclick="sendName();">Send</button>
        <p id="response"></p>
    </div>
</div>
</body>

</html>
