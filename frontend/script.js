const apiEndpoint = "https://<your-api-gateway-url>"; // Replace with your API Gateway URL

async function updateVisitorCount() {
    try {
        const response = await fetch(apiEndpoint);
        const data = await response.json();
        document.getElementById('visitor-count').innerText = `Visitors: ${data.count}`;
    } catch (error) {
        console.error('Error fetching visitor count:', error);
        document.getElementById('visitor-count').innerText = 'Visitors: Unavailable';
    }
}

// Call the function on page load
document.addEventListener('DOMContentLoaded', updateVisitorCount);
