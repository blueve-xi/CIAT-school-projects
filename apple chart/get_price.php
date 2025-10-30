<?php
header('Content-Type: application/json');

// This function simulates stock price data
// For a real-world application, you would get this from a stock API
function getSimulatedPrice() {
    // Check if a session variable exists to maintain the last price
    session_start();
    if (!isset($_SESSION['aapl_price'])) {
        $_SESSION['aapl_price'] = 270.00; // Initial price
    }
    
    // Get the last known price
    $lastPrice = $_SESSION['aapl_price'];
    
    // Generate a random change (-1.00 to +1.00)
    $change = mt_rand(-100, 100) / 100;
    
    // Apply the change and ensure the price doesn't go negative
    $newPrice = max(50.00, $lastPrice + $change);
    
    // Store the new price
    $_SESSION['aapl_price'] = $newPrice;

    return [
        'price' => round($newPrice, 2),
        'timestamp' => date('H:i:s')
    ];
}

echo json_encode(getSimulatedPrice());
?>
