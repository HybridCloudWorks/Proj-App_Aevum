import io
import os
import tracemalloc
from PIL import Image

def run_benchmark():
    # Create a dummy large image (e.g., a 12 megapixel image)
    img_size = (4000, 3000)
    print(f"Creating a dummy {img_size[0]}x{img_size[1]} image...")
    dummy = Image.new('RGB', img_size, color='red')
    test_file = 'dummy.jpg'
    dummy.save(test_file, quality=95)

    file_size_mb = os.path.getsize(test_file) / (1024 * 1024)
    print(f"Dummy file size: {file_size_mb:.2f} MB")

    # Benchmark 1: In-Memory (current implementation approach)
    tracemalloc.start()
    with open(test_file, 'rb') as f:
        content = f.read()

    img1 = Image.open(io.BytesIO(content))
    img1.thumbnail((1920, 1920))
    out1 = io.BytesIO()
    img1.save(out1, format='WEBP', quality=85)
    out1.seek(0)

    out1_thumb = io.BytesIO()
    img1.thumbnail((200, 200))
    img1.save(out1_thumb, format='WEBP', quality=80)
    out1_thumb.seek(0)

    _, peak_mem_in_memory = tracemalloc.get_traced_memory()
    tracemalloc.stop()

    # Benchmark 2: Disk-based (optimized approach)
    tracemalloc.start()
    img2 = Image.open(test_file)
    img2.thumbnail((1920, 1920))
    out2 = io.BytesIO()
    img2.save(out2, format='WEBP', quality=85)
    out2.seek(0)

    out2_thumb = io.BytesIO()
    img2.thumbnail((200, 200))
    img2.save(out2_thumb, format='WEBP', quality=80)
    out2_thumb.seek(0)

    _, peak_mem_disk = tracemalloc.get_traced_memory()
    tracemalloc.stop()

    print(f"\n--- Results ---")
    print(f"Peak memory (In-Memory Bytes): {peak_mem_in_memory / (1024 * 1024):.2f} MB")
    print(f"Peak memory (Disk-Based):      {peak_mem_disk / (1024 * 1024):.2f} MB")

    improvement = peak_mem_in_memory - peak_mem_disk
    print(f"Memory saved: {improvement / (1024 * 1024):.2f} MB")

    # Cleanup
    os.remove(test_file)

if __name__ == '__main__':
    run_benchmark()
