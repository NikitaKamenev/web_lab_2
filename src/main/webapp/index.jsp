<%@ page import="model.Point" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ListIterator" %>
<jsp:useBean id='PointsBean' scope='session' class='model.PointsBean' />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Web | Lab 2</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header>
    <h1>Лабораторная работа №2</h1>
    <h2>Технологии разработки интерактивных цифровых ресурсов <br>aka Веб-программирование</h2>
    <p>Выполнили: Каменев Никита, Рыжов Никита</p>
    <p>Группа: P33212</p>
    <p>Вариант: 5981</p>
</header>
<main>
    <article>
        <section>
            <form action="/check" method="post" id="check_form">
                <div id="error"></div>
                <fieldset>
                    <legend>Выберете координату X:</legend>
                    <div class="buttons_wrapper">
                        <button name="x">-4</button>
                        <button name="x">-3</button>
                        <button name="x">-2</button>
                        <button name="x">-1</button>
                        <button name="x">0</button>
                        <button name="x">1</button>
                        <button name="x">2</button>
                        <button name="x">3</button>
                        <button name="x">4</button>
                    </div>
                </fieldset>

                <fieldset>
                    <legend>Выберете координату Y:</legend>
                    <div class="text_wrapper">
                        <input type="text" name="y" placeholder="-3 .. 5">
                    </div>
                </fieldset>

                <fieldset>
                    <legend>Выберете радиус R:</legend>
                    <div class="checkbox_wrapper">
                        <select name="r">
                            <option value="">-</option>
                            <option value="1">1</option>
                            <option value="1.5">1.5</option>
                            <option value="2">2</option>
                            <option value="2.5">2.5</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                </fieldset>
                <input id="button_submit" name="submit" type="submit" value="Проверить">
                <input id="button_reset" name="reset" type="button" value="Очистить хранилище">
            </form>
        </section>
        <section class="svg_wrapper">
            <svg id="chart" width="500" height="500" viewBox="0 0 500 500" fill="none" xmlns="http://www.w3.org/2000/svg">
                <polygon points="250,50 150,250 250,250" fill="#3485FF" />
                <mask id="quarter" maskUnits="userSpaceOnUse" x="250" y="250" width="200" height="200">
                    <circle cx="250" cy="250" r="200" fill="#FFFFFF"/>
                </mask>
                <g mask="url(#quarter)">
                    <rect x="250" y="250" width="200" height="200" fill="#3485FF"/>
                </g>
                <rect x="50" y="250" width="200" height="100" fill="#3485FF"/>


                <line x1="250" y1="0" x2="250" y2="500" stroke-width=2 stroke="black"/>

                <text x="265" y="10"  fill="black" font-family="sans-serif" font-size="18">y</text>
                <line x1="250" y1="0" x2="245" y2="12" stroke-width=2 stroke="black"/>
                <line x1="255" y1="12" x2="250" y2="0" stroke-width=2 stroke="black"/>

                <line x1="500" y1="250" x2="0" y2="250" stroke-width=2 stroke="black"/>

                <text x="490" y="240"  fill="black" font-family="sans-serif" font-size="18">x</text>
                <line x1="500" y1="250" x2="488" y2="245" stroke-width=2 stroke="black"/>
                <line x1="488" y1="255" x2="500" y2="250" stroke-width=2 stroke="black"/>


                <text x="350" y="240" class="r2p" fill="black" font-family="sans-serif" font-size="18">R/2</text>
                <line x1="350" y1="245" x2="350" y2="255" stroke-width=2 stroke="black"/>

                <text x="260" y="150" class="r2p" fill="black" font-family="sans-serif" font-size="18">R/2</text>
                <line x1="245" y1="150" x2="255" y2="150" stroke-width=2 stroke="black"/>

                <text x="150" y="240" class="r2n" fill="black" font-family="sans-serif" font-size="18">-R/2</text>
                <line x1="150" y1="245" x2="150" y2="255" stroke-width=2 stroke="black"/>

                <text x="260" y="350" class="r2n" fill="black" font-family="sans-serif" font-size="18">-R/2</text>
                <line x1="255" y1="350" x2="245" y2="350" stroke-width=2 stroke="black"/>

                <text x="450" y="240" class="rp" fill="black" font-family="sans-serif" font-size="18">R</text>
                <line x1="450" y1="245" x2="450" y2="255" stroke-width=2 stroke="black"/>

                <text x="260" y="55" class="rp" fill="black" font-family="sans-serif" font-size="18">R</text>
                <line x1="245" y1="50" x2="255" y2="50" stroke-width=2 stroke="black"/>

                <text x="50" y="240" class="rn" fill="black" font-family="sans-serif" font-size="18">-R</text>
                <line x1="50" y1="245" x2="50" y2="255" stroke-width=2 stroke="black"/>

                <text x="260" y="450" class="rn" fill="black" font-family="sans-serif" font-size="18">-R</text>
                <line x1="245" y1="450" x2="255" y2="450" stroke-width=2 stroke="black"/>
            </svg>
        </section>

    </article>
    <aside>
        <table id="result_table">
            <caption>Результаты проверки</caption>
            <thead>
            <tr>
                <th>№</th>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Попадание</th>
                <th>Время выполнения</th>
                <th>Текущее время</th>
            </tr>
            </thead>
            <tbody>

    <%
        List<Point> pointsList = PointsBean.getPoints();

        ListIterator<Point> points = pointsList.listIterator(pointsList.size());

        while (points.hasPrevious()) {
            Point p = points.previous();
    %>
    <tr class="<%= p.isHit() ? "hit" : "lose" %>">
        <td><%= p.getId() %></td>
        <td><%= p.getX() %></td>
        <td><%= p.getY() %></td>
        <td><%= p.getR() %></td>
        <td><%= p.isHit() ? "Да" : "Нет" %></td>
        <td><%= p.getExecutionTimeMS() %> ms</td>
        <td><%= p.getCurrentTime() %></td>
    </tr>
    <% } %>
            </tbody>
        </table>
    </aside>
</main>



<footer>
    <svg width="236" height="64" viewBox="0 0 236 64" fill="none" xmlns="http://www.w3.org/2000/svg">
        <g clip-path="url(#clip0_145_1646)">
            <path d="M61.8346 28.1432H79.1647V63.5715H91.8565V28.1432H109.512V16.809H61.8346V28.1432Z" fill="#1D1D1B"/>
            <path d="M57.7332 16.7128H44.927V63.5715H57.7332V16.7128Z" fill="#1D1D1B"/>
            <path d="M0.338501 16.7128V63.5715H13.1447V16.7128H0.338501Z" fill="#1D1D1B"/>
            <path d="M32.455 16.7128L13.1445 63.5715H26.3468L44.9179 16.7128H39.8219H32.455Z" fill="#1D1D1B"/>
            <path d="M169.979 16.7128H168.28H160.904L148.195 47.5584L135.486 16.7128H128.119H123.023H113.605V63.5715H126.411V25.2659L141.594 63.5715H154.796L169.979 25.2659V63.5715H182.785V16.7128H173.367H169.979Z" fill="#1D1D1B"/>
            <path d="M51.3257 -3.83679e-06C50.088 0.024117 48.885 0.410962 47.8677 1.11198C46.8504 1.813 46.0642 2.79696 45.6076 3.94038C45.1511 5.0838 45.0446 6.33573 45.3015 7.53906C45.5584 8.7424 46.1673 9.84353 47.0518 10.7043C47.9363 11.565 49.0569 12.147 50.273 12.3771C51.4891 12.6073 52.7465 12.4755 53.8875 11.9982C55.0285 11.5208 56.0022 10.7192 56.6864 9.69404C57.3705 8.66884 57.7347 7.4657 57.7332 6.23558C57.7147 4.56475 57.0294 2.96955 55.828 1.80038C54.6266 0.631208 53.0073 -0.0163285 51.3257 -3.83679e-06Z" fill="#1D1D1B"/>
            <path d="M222.919 40.7991C222.752 48.0054 217.894 52.8417 210.844 52.8417H210.58C206.786 52.7717 203.662 51.5561 201.541 49.3435C199.419 47.1309 198.328 43.86 198.398 39.977C198.316 38.3586 198.58 36.7412 199.173 35.2317C199.767 33.7223 200.676 32.3553 201.841 31.221C203.006 30.0868 204.399 29.2112 205.93 28.6521C207.461 28.0931 209.094 27.8633 210.721 27.9781C212.342 27.9213 213.959 28.1928 215.472 28.7761C216.985 29.3594 218.363 30.2424 219.522 31.3714C220.695 32.6415 221.6 34.1327 222.182 35.7567C222.764 37.3807 223.012 39.1043 222.911 40.8253L222.919 40.7991ZM223.914 19.9934C219.994 17.7426 215.538 16.5769 211.011 16.6176C209.835 16.6204 208.659 16.6876 207.49 16.8187C200.616 17.5709 195.089 20.4219 191.058 25.2932C187.273 29.8671 185.636 35.4468 186.059 42.3295C186.217 47.0961 187.932 51.6821 190.944 55.3954C195.784 61.2724 202.386 64.0797 211.812 64.2284H211.918H212.023L213.247 64.071C214.89 63.8888 216.519 63.5966 218.123 63.1964C222.931 62.0028 227.227 59.3047 230.374 55.5004C233.437 51.6638 235.166 46.9446 235.303 42.0497C235.717 32.0185 231.888 24.5586 223.923 19.9934" fill="#1D1D1B"/>
        </g>
        <defs>
            <clipPath id="clip0_145_1646">
                <rect width="235" height="64" fill="white" transform="translate(0.338501)"/>
            </clipPath>
        </defs>
    </svg>

</footer>
<script src="jquery-3.6.0.min.js"></script>
<script src="script.js"></script>
</body>
</html>