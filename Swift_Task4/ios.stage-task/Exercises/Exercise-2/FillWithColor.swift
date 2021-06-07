import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        if (image == [[]] || row < 0 || column < 0 ||
                row >= image.count || column >= image[0].count)
        {
            return image
        }
        let oldColor = image[row][column]
        var result : [Array<Int>] = image
        if (oldColor != newColor)
        {
            result = coloring(image, row, column, newColor)
        }
        else
        {
            return image
        }
        return result
    }
    
    func coloring(_ arr: [Array<Int>], _ row: Int, _ col: Int,_ newColor: Int) -> [Array<Int>] {
        var newImage: [Array<Int>] = arr
        if (newImage[row][col] == newColor)
        {
            return newImage
        }
        let oldColor = newImage[row][col]
        newImage[row][col] = newColor
        let up = row + 1
        let down = row - 1
        let right = col + 1
        let left = col - 1
        if (up < newImage.count && newImage[up][col] == oldColor)
        {
            newImage = coloring(newImage, up, col, newColor)
        }
        if (down >= 0 && newImage[down][col] == oldColor)
        {
            newImage = coloring(newImage, down, col, newColor)
        }
        if (right < newImage[row].count && newImage[row][right] == oldColor)
        {
            newImage = coloring(newImage, row, right, newColor)
        }
        if (left >= 0 && newImage[row][left] == oldColor)
        {
            newImage = coloring(newImage, row, left, newColor);
        }
        return newImage
    }
}
