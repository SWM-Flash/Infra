<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Upload</title>
    <script src="https://cdn.jsdelivr.net/npm/compressorjs@1.0.7/dist/compressor.min.js"></script>
</head>
<body>
    <h1>Image Upload</h1>
    <form id="uploadForm">
        <label for="images">Choose images:</label>
        <input type="file" id="images" name="images" accept="image/*" multiple required><br><br>

        <label for="difficulty">Difficulty:</label>
        <select id="difficulty" name="difficulty" required>
            <option value="초록">초록</option>
            <option value="파랑">파랑</option>
            <option value="빨강">빨강</option>
            <option value="보라">보라</option>
            <option value="회색">회색</option>
            <option value="갈색">갈색</option>
            <option value="검정">검정</option>
            <option value="검정">흰색</option>
            <option value="검정">남색</option>
            <option value="시크릿">시크릿</option>
        </select><br><br>

        <label for="gym_id">Gym ID:</label>
        <input type="number" id="gym_id" name="gym_id" required><br><br>

        <label for="sector_id">Sector ID:</label>
        <input type="number" id="sector_id" name="sector_id" required><br><br>

        <label for="image_source">Image Source:</label>
        <input type="text" id="image_source" name="image_source" required><br><br>

        <label for="access_token">Access Token:</label>
        <input type="text" id="access_token" name="access_token" required><br><br>

        <button type="submit">Upload</button>
    </form>

    <div id="response"></div>

    <script>
        document.getElementById('uploadForm').addEventListener('submit', async function(event) {
            event.preventDefault();

            const images = document.getElementById('images').files;
            const difficulty = document.getElementById('difficulty').value;
            const gym_id = document.getElementById('gym_id').value;
            const sector_id = document.getElementById('sector_id').value;
            const image_source = document.getElementById('image_source').value;
            const access_token = document.getElementById('access_token').value;
		
	        const presigned_url = "${api_gateway_url}/problem/get-presigned-url";
            const upload_url = "${api_gateway_url}/problem"

            const responses = [];

            for (const image of images) {
                await new Promise((resolve, reject) => {
                    new Compressor(image, {
                        quality: 0.6, // 압축 품질 설정 (0 ~ 1)
                        mimeType: 'image/webp', // 웹프 형식으로 압축
                        success(result) {
                            // Step 1: Get presigned URL
                            fetch(presigned_url)
                                .then(response => response.json())
                                .then(presignedUrlData => {
                                    const uploadUrl = presignedUrlData.upload_url;
                                    const fileName = presignedUrlData.file_name;

                                    // Step 2: Upload image
                                    fetch(uploadUrl, {
                                        method: 'PUT',
                                        headers: {
                                            'Content-Type': 'image/webp'
                                        },
                                        body: result
                                    }).then(() => {
                                        // Step 3: Send file name and other data to server
                                        let postData = {
                                            image_url: fileName,
                                            difficulty: difficulty,
                                            image_source: image_source,
                                            gym_id: gym_id,
                                            sector_id: sector_id,
                                            token: access_token
                                        };

                                        fetch(upload_url, {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/json'
                                            },
                                            body: JSON.stringify(postData)
                                        })
                                            .then(postResponse => postResponse.json())
                                            .then(postResult => {
                                                // Step 4: Store response
                                                responses.push(postResult);
                                                resolve();
                                            });
                                        });
                                });
                        },
                        error(err) {
                            console.log(err.message);
                            reject(err);
                        },
                    });
                });
            }

            // Display all responses
            document.getElementById('response').textContent = JSON.stringify(responses, null, 2);
        });
    </script>
</body>
</html>
