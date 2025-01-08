#!/bin/bash

GCAL_URL="https://calendar.google.com/calendar/r?cid=webcal://daehyeoni.dev/holidays-kr/holidays.ics"

cat > public/index.html << EOF
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대한민국 공휴일 데이터</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen py-8">
    <div class="container mx-auto px-4">
        <h1 class="text-3xl font-bold mb-8">대한민국 공휴일 데이터</h1>
        
        <div class="bg-white rounded-lg shadow-md p-6 mb-8">
            <h2 class="text-xl font-semibold mb-4">파일 목록</h2>
            <ul class="space-y-2">
EOF

# Add holidays.ics with current date
echo "<li class=\"flex items-center justify-between py-2 border-b\">" >> public/index.html
echo "    <span class=\"font-medium\">holidays.ics</span>" >> public/index.html
echo "    <div class=\"space-x-4\">" >> public/index.html
echo "        <a href=\"holidays.ics\" class=\"text-blue-500 hover:text-blue-700\">다운로드</a>" >> public/index.html
echo "        <a href=\"${GCAL_URL}\" class=\"text-green-500 hover:text-green-700\" target=\"_blank\">Google Calendar에 추가</a>" >> public/index.html
echo "    </div>" >> public/index.html
echo "</li>" >> public/index.html

# Add JSON files with their last modified dates
for file in public/*.json; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "<li class=\"flex items-center justify-between py-2 border-b\">" >> public/index.html
        echo "    <span class=\"font-medium\">$filename</span>" >> public/index.html
        echo "    <a href=\"$filename\" class=\"text-blue-500 hover:text-blue-700\">다운로드</a>" >> public/index.html
        echo "</li>" >> public/index.html
    fi
done

cat >> public/index.html << EOF
            </ul>
        </div>

        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold mb-4">사용 방법</h2>
            <div class="prose">
                <h3 class="text-lg font-medium mb-2">Google Calendar에 추가하기</h3>
                <p class="mb-4">
                    "Google Calendar에 추가" 버튼을 클릭하면 자동으로 Google Calendar에 구독이 추가됩니다.
                </p>

                <h3 class="text-lg font-medium mb-2">다른 캘린더 앱에서 구독하기</h3>
                <p class="mb-2">
                    아래 URL을 캘린더 앱의 구독 기능에 직접 입력하여 사용할 수 있습니다:
                </p>
                <code class="bg-gray-100 p-2 rounded block mb-4">
                    https://daehyeoni.dev/$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)/holidays.ics
                </code>

                <h3 class="text-lg font-medium mb-2">JSON 데이터</h3>
                <p class="mb-4">
                    JSON 데이터는 연도별로 제공됩니다. 각 JSON 파일은 해당 연도의 공휴일 정보를 포함하고 있습니다.
                </p>
            </div>
        </div>

        <footer class="mt-8 text-center text-gray-600">
            <p>데이터 출처: <a href="https://www.data.go.kr/data/15012690/openapi.do">공공데이터포털 (공휴일 정보)</a></p>
            <p class="mt-2">
                <a href="https://github.com/${GITHUB_REPOSITORY}" class="text-blue-500 hover:text-blue-700">GitHub Repository</a>
            </p>
        </footer>
    </div>
</body>
</html>
EOF
